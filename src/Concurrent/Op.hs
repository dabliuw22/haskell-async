module Concurrent.Op where

import Control.Applicative
import Control.Concurrent
import Control.Concurrent.Async
import Control.Exception
import Data.Typeable

newtype AsyncTask a = AsyncTask (MVar (Either SomeException a))

asyncTask :: IO a -> IO (AsyncTask a)
asyncTask action = do
  var <- newEmptyMVar
  forkIO (do a <- try action; putMVar var a)
  return (AsyncTask var)

waitTask :: AsyncTask a -> IO a
waitTask (AsyncTask a) = do
  var <- readMVar a
  case var of
    Right v -> return v
    Left e  -> throwIO e

newConcurrentTask :: IO String
newConcurrentTask = do
  async1 <- asyncTask $ run "Hello"
  async2 <- asyncTask $ run "World"
  var1 <- waitTask async1
  var2 <- waitTask async2
  return (var1 ++ " " ++ var2)

run :: String -> IO String
run s = do threadDelay 100 >>= \ x -> return s

runError :: String -> IO String
runError s = do threadDelay 100 >>= \ x -> throwIO (AsyncTaskException "Boom...")

data AsyncTaskException = AsyncTaskException String deriving Show

instance Exception AsyncTaskException
{--
concurrentTaskAsync :: IO String
concurrentTaskAsync = do
  (h, s, w) <- runConcurrently $ (,,)
    <$> Concurrently (run "Hello")
    <*> Concurrently (runError " " `catch` asyncTaskHandler)
    <*> Concurrently (run "World")
  return (h ++ s ++ w)
-}
concurrentTaskAsync :: IO String
concurrentTaskAsync = do
  (h, s, w) <- runConcurrently $ (,,)
    <$> Concurrently (run "Hello")
    <*> Concurrently (runError " ")
    <*> Concurrently (run "World")
  return (h ++ s ++ w) `catch` asyncTaskHandler
  
asyncTaskHandler :: AsyncTaskException -> IO String
asyncTaskHandler (AsyncTaskException m) = pure (show m)