{-|
Module      : ExprType
Description : ...
Copyright   : (c) Andy Ng @2018
Licence     : WTFPL
Maintainer  : nga15@mcmaster.ca
Stability   : experimental
Portability : POSIX
-}

module ExprType where

import           Data.List

-- Declaration for the Expr Datatype

data Expr a = Add (Expr a) (Expr a)     -- Addition
            | Sub (Expr a) (Expr a)     -- Subtraction
            | Mult (Expr a) (Expr a)    -- Mulitplication
            | Div (Expr a) (Expr a)     -- Division
            | Sin (Expr a)              -- Sine
            | Cos (Expr a)              -- Cosine
            | Tan (Expr a)              -- Tangent
            | Log a (Expr a)            -- Log base a
            | Ln (Expr a)               -- Ln
            | Exp a (Expr a)            -- Exp - Const n to the Expr a
            | Pow (Expr a) (Expr a)     -- Power - Expr a to the n
            | Const a                   -- Constant
            | Var String                -- Variable
  deriving Eq

-- getVars Function - ... 

getVars :: Expr a -> [String]
getVars (Add e1 e2)  = getVars e1 ++ getVars e2
getVars (Sub e1 e2)  = getVars e1 ++ getVars e2
getVars (Mult e1 e2) = getVars e1 ++ getVars e2
getVars (Div e1 e2)  = getVars e1 ++ getVars e2
getVars (Sin e)      = getVars e
getVars (Cos e)      = getVars e
getVars (Tan e)      = getVars e
getVars (Log n e)    = getVars e
getVars (Ln e)       = getVars e
getVars (Exp n e)    = getVars e
getVars (Pow e1 e2)  = getVars e1 ++ getVars e2
getVars (Const _)    = []
getVars (Var x)      = [x]