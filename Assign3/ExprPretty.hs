{-|
Module      : ExprPretty
Description : Takes Expr expressions and returns it in a Pretty format
Copyright   : (c) Andy Ng @2018
Licence     : WTFPL
Maintainer  : nga15@mcmaster.ca
Stability   : experimental
Portability : POSIX
-}

module ExprPretty where

import           ExprType

-- parens Function - Wraps the expression in parenthesis

parens :: String -> String
parens ss = "(" ++ ss ++ ")"

-- Formats the expressions with the mathematical operators/ functions used

instance Show a => Show (Expr a) where
  show (Add e1 e2)  = parens (show e1) ++ " !+ " ++ parens (show e2)
  show (Sub e1 e2)  = parens (show e1) ++ " !- " ++ parens (show e2)
  show (Mult e1 e2) = parens (show e1) ++ " !* " ++ parens (show e2)
  show (Div e1 e2)  = parens (show e1) ++ " !/ " ++ parens (show e2)
  show (Sin e)      = "Sin" ++ parens (show e)
  show (Cos e)      = "Cos" ++ parens (show e)
  show (Tan e)      = "Tan" ++ parens (show e)
  show (Log n e)    = "Log" ++ show (n) ++ " " ++ parens (show e)
  show (Ln e)       = "Ln" ++ parens (show e)
  show (Exp n e)    = show (n) ++ "**" ++ parens (show e)
  show (Pow e1 e2)  = parens (show e1) ++ "**" ++ parens (show (e2))
  show (Var x)      = x
  show (Const x)    = show x