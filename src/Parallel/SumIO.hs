{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE LambdaCase #-}

module Parallel.SumIO where

import qualified Control.Concurrent.ParallelIO.Global as G
import qualified Control.Concurrent.ParallelIO.Local as L
import Parallel.Sum (parSum)

parSumIO :: [Int] -> IO Int
parSumIO list = pure $ parSum list

execWithLocalPool :: L.Pool -> IO Int
execWithLocalPool pool =
  L.parallel pool [parSumIO [1, 2, 3], parSumIO [4, 5, 6]]
    >>= ( \case
            (h : t) -> pure $ sum (h : t)
            _ -> pure 0
        )

execWithImplicitGlobalPool :: IO Int
execWithImplicitGlobalPool =
  G.parallel [parSumIO [1, 2, 3], parSumIO [4, 5, 6]]
    >>= ( \case
            (h : t) -> pure $ sum (h : t)
            _ -> pure 0
        )
