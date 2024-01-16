module Main where

-- 只支持 Windows ，但是现在高版本 ghcup 都是用 linux 环境，windows 下是 mingw32 封装的。
-- 而且这个库封装 libxls ，libxls 是不支持图片的。
import Data.List (intercalate)
import Data.Xls (decodeXlsIO)

xlsToCSV :: String -> IO ()
xlsToCSV file = do
    worksheets <- decodeXlsIO file
    mapM_ (mapM_ (putStrLn . intercalate ",")) worksheets

main :: IO ()
main = putStrLn "Hello, Haskell!"
