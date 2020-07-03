module Parallel.Sum where

import Control.Parallel.Strategies
import Control.Monad.Par

parSum :: [Int] -> Int
parSum list = foldr (+) 0 list

execEval :: Int
execEval = runEval $ do
  s1 <- rpar (parSum [1, 2, 3])
  s2 <- rpar (parSum [4, 5, 6])
  rseq s1
  rseq s2
  return (s1 + s2)

execEvalIO :: IO Int
execEvalIO = runEvalIO $ do
    s1 <- rpar (parSum [1, 2, 3])
    s2 <- rpar (parSum [4, 5, 6])
    rseq s1
    rseq s2
    return (s1 + s2)

execPar :: Int
execPar = runPar $ do
  s1 <- new -- Create IVar
  s2 <- new -- Create IVar
  fork (put s1 (parSum [1, 2, 3])) -- run parSum into IVar
  fork (put s2 (parSum [4, 5, 6])) -- run parSum into IVar
  s1' <- get s1 -- wait for the results from s1
  s2' <- get s2 -- wait for the results from s1
  return (s1' + s2')