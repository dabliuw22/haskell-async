module Channel.ChannelMain where

import Channel.Program (threadHello)
import Control.Concurrent
  ( forkIO,
    newChan,
    newEmptyMVar,
    putMVar,
    readChan,
  )
import System.IO
  ( BufferMode (..),
    hSetBuffering,
    stdout,
  )

channel :: IO ()
channel = do
  hSetBuffering stdout NoBuffering
  flags <- newChan
  mutex <- newEmptyMVar
  let n = 20
  mapM_ (\_ -> forkIO $ threadHello mutex flags) [1 .. n]
  -- Init Mutex, para que inicie la primera threadHello
  putMVar mutex ()
  -- Wait
  mapM_ (\_ -> readChan flags) [1 .. n]
