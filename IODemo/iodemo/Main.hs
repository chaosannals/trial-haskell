module Main where

import System.Directory
import System.FilePath

main :: IO ()
main = do
    currentDir <- getCurrentDirectory
    putStrLn (currentDir </> ".env")
