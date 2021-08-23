module Async.Task where

import Control.Concurrent.Async

run :: IO String -> IO String
run action = do
  mVar <- async action
  result <- waitCatch mVar --wait mVar
  case result of
    Right a -> return a
    Left e -> return "Error"
