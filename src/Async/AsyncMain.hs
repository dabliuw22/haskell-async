module Async.AsyncMain where

import Async.Task
import Control.Concurrent (threadDelay)

async :: IO ()
async = do 
  v <- run $ action "Hello World"
  print v

action :: String -> IO String
action s = do threadDelay 100 >>= \ x -> return s
