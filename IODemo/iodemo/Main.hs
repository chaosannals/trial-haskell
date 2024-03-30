module Main where

import System.Directory
import System.FilePath
import System.Log.Logger
import System.Log.Handler.Simple

main :: IO ()
main = do
    logHandler <- fileHandler "my.log" INFO
    let name = "aaa"
    updateGlobalLogger name (setHandlers [logHandler])
    updateGlobalLogger name (setLevel INFO)
    currentDir <- getCurrentDirectory
    debugM name "bbbb"
    infoM name currentDir
    putStrLn (currentDir </> ".env")
