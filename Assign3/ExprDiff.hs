{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE UndecidableInstances #-}
module ExprDiff where

import           ExprType

import qualified Data.Map.Strict as Map

class DiffExpr a where
  eval :: Map.Map String a -> Expr a -> a
  simplify :: Map.Map String a -> Expr a -> Expr a
  partDiff :: String -> Expr a -> Expr a

  (!+) :: Expr a -> Expr a -> Expr a
  e1 !+ e2 = simplify (Map.fromList []) $ Add e1 e2
  (!-) :: Expr a -> Expr a -> Expr a
  e1 !- e2 = simplify (Map.fromList []) $ Sub e1 e2
  (!*) :: Expr a -> Expr a -> Expr a
  e1 !* e2 = simplify (Map.fromList []) $ Mult e1 e2
  (!/) :: Expr a -> Expr a -> Expr a
  e1 !/ e2 = simplify (Map.fromList []) $ Div e1 e2
  val :: a -> Expr a
  val x = Const x
  var :: String -> Expr a
  var x = Var x


instance (Num a) => DiffExpr a where
  eval vrs (Add e1 e2)  = eval vrs e1 + eval vrs e2
  eval vrs (Mult e1 e2) = eval vrs e1 * eval vrs e2
  eval vrs (Const x) = x
  eval vrs (Var x) = case Map.lookup x vrs of
                       Just v  -> v
                       Nothing -> error "failed lookup in eval"
  simplify _ e = e -- #TODO finish me!
  --partDiff _ e = e -- #TODO finish me!

  partDiff x (Add e1 e2) = Add (partDiff x e1) (partDiff x e2)
  partDiff x (Sub e1 e2) = Sub (partDiff x e1) (partDiff x e2)
  partDiff x (Mult e1 e2) = let
                                p1 = Mult (partDiff x e1) e2
                                p2 = Mult e1 (partDiff x e2)
                            in Add p1 p2
  partDiff x (Div e1 e2) = let 
                                p1 = Mult (partDiff x e1) e2
                                p2 = Mult e1 (partDiff x e2)
                                p3 = Pow (e2) (Const (2))
                            in Div (Sub p1 p2) p3

  partDiff x (Sin e) = Mult (Cos (e)) (partDiff x e) 
  partDiff x (Cos e) = Mult (Mult (Sin (e)) (partDiff x e)) (Const (-1))
  partDiff x (Tan e) = let
                            p1 = Div (Const 1) (Pow (Cos e) (Const(2)))
                            p2 = partDiff x e
                        in Mult p1 p2

  partDiff x (Log n e) = let 
                            p1 = Div (Const (1)) (Ln (Const (n)))
                            p2 = Div (Const (1)) e
                            p3 = partDiff x e
                        in Mult (Mult p1 p2) p3
  partDiff x (Ln e) = let
                            p1 = Div (Const (1)) e
                            p2 = partDiff x e
                        in Mult p1 p2

  partDiff x (Exp n e) = let
                            p1 = Exp n e
                            p2 = Ln (Const n)
                            p3 = partDiff x e
                        in Mult (Mult p1 p2) p3
  partDiff x (Pow e1 e2) = let
                            p1 = (Const (2)) 
                            p2 = (Mult e2 (Ln (e1)))
                        in Mult p1 p2

  partDiff _ (Const a) = Const 0
  partDiff x (Var a) = if a == x then Const (1) else Const (0)