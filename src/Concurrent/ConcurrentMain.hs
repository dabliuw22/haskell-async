module Concurrent.ConcurrentMain where

import qualified Concurrent.Op as C
import Control.Exception

concurrent :: IO ()
concurrent = do 
  s2 <- C.newConcurrentTask
  print s2
  s3 <- C.concurrentTaskAsync `catch` (\e -> pure $ show (e :: C.AsyncTaskException))
  print s3