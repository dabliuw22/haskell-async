{-# LANGUAGE BlockArguments #-}

module Main where

import Async.AsyncMain
import Channel.ChannelMain
import Concurrent.ConcurrentMain
import Parallel.ParallelMain

main :: IO ()
--main = parallel
--main = concurrent
main = channel

--main = async
