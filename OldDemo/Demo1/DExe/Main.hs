module Main where

import Text.Printf(printf)
import Control.Concurrent (forkFinally)
import Control.Monad (forever, unless, void)
import qualified Control.Exception as E
import qualified Data.ByteString as S
import Network.Socket (
    withSocketsDo,
    listen,
    socket,
    bind,
    accept,
    close,
    openSocket,
    setSocketOption,
    getAddrInfo,
    addrFlags,
    addrAddress,
    addrSocketType,
    defaultHints,
    gracefulClose,
    setCloseOnExecIfNeeded,
    withFdSocket,
    SocketOption(ReuseAddr),
    Socket,
    AddrInfoFlag(AI_PASSIVE),
    SocketType(Stream),
    Family(AF_INET))
import Network.Socket.ByteString (recv, sendAll)
import System.IO (Handle, hGetLine, hPutStrLn, hSetBuffering,  BufferMode(LineBuffering))
import LibDemo1 (sayHello)

main :: IO ()
main = withSocketsDo $ do
    sayHello
    addr <- resolve
    E.bracket (open addr) close loop
    -- printf "listen port %s \n" addr 
        -- (handle, host, port) <- accept sock
        -- printf "accept %s: %s \n" host (show port)
--         forkFinally (talk handle) (\_ -> hClose handle)
    where
        resolve = do
            let hints = defaultHints {
                    addrFlags = [AI_PASSIVE]
                , addrSocketType = Stream
                }
            head <$> getAddrInfo (Just hints) Nothing (Just "44444")
        open addr = E.bracketOnError (openSocket addr) close $ \sock -> do
            setSocketOption sock ReuseAddr 1
            withFdSocket sock setCloseOnExecIfNeeded
            bind sock $ addrAddress addr
            listen sock 1024
            return sock
        loop sock = forever $ E.bracketOnError (accept sock) (close . fst)
            $ \(conn, _peer) -> void $
                forkFinally (serve conn) (const $ gracefulClose conn 5000)
        serve conn = talk conn

talk :: Socket -> IO ()
talk s = do
    msg <- recv s 1024
    unless (S.null msg) $ do
        sendAll s msg
        talk s

-- talk :: Handle -> IO ()
-- talk h = do
    -- hSetBuffering h LineBuffering
    -- loop
    -- where
    --     loop = do
    --         line <- hGetLine h
    --         if line == "end"
    --             then hPutStrLn h "thank"
    --             else do
    --                 loop