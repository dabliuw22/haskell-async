{-# LANGUAGE BlockArguments #-}
module Main where

import Async.AsyncMain
import Concurrent.ConcurrentMain
import Parallel.ParallelMain

main :: IO ()
--main = parallel
main = concurrent
--main = async