module Main where


import Control.Exception (catch, SomeException)
import System.Environment (getArgs)
import System.Directory (doesFileExist)

countWords :: String -> [Int]
countWords input = map (length.words) (lines input)


main :: IO ()
main = do
    putStrLn "Hello, Haskell!"

    putStrLn "count Words"
    args <- getArgs
    let filename = case args of -- 下面的子句必须比 case 的缩进后。
                    [] -> "input.txt"
                    x:_ -> x

    exists <- doesFileExist filename

    print $ exists

    input <- catch (readFile filename) (\e -> print(e::SomeException) >> return "")
    print $ countWords input

    putStrLn "End, Haskell!"
        
