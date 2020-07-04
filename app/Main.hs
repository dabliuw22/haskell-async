{-# LANGUAGE BlockArguments #-}
module Main where

import Parallel.ParallelMain
import Concurrent.ConcurrentMain

main :: IO ()
--main = parallel
main = concurrent