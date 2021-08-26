{-# LANGUAGE BangPatterns #-}

module Channel.Program (threadHello) where

import Control.Concurrent
  ( Chan,
    MVar,
    myThreadId,
    putMVar,
    takeMVar,
    writeChan,
  )

getGreeting :: IO String
getGreeting = do
  threadId <- myThreadId
  let greeting = "Hello from " <> show threadId
  return $! greeting

-- Chan (Return Value)
threadHello :: MVar () -> Chan () -> IO ()
threadHello mutex flags = do
  greeting <- getGreeting
  takeMVar mutex
  putStrLn greeting
  putMVar mutex ()
  writeChan flags ()
