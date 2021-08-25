module Parallel.ParallelMain where

import qualified Control.Concurrent.ParallelIO.Global as G
import qualified Control.Concurrent.ParallelIO.Local as L
import Parallel.Sum
import Parallel.SumIO

parallel :: IO ()
parallel = do
  let eval = execEval
  print eval
  evalIO <- execEvalIO
  print evalIO
  let par = execPar
  print par
  localIO <- L.withPool 10 (execWithLocalPool)
  print localIO
  globalIO <- execWithImplicitGlobalPool
  print globalIO
  G.stopGlobalPool
