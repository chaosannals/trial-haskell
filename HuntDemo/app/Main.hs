module Main where

import Control.Exception (catch, SomeException)
import System.Environment (getArgs)
import System.Directory (doesFileExist)
import Text.CSV

countWords :: String -> [Int]
countWords input = map (length.words) (lines input)

findOldest :: [Record] -> Record
findOldest [] = []
findOldest xs = foldl1 (\a x -> if age x > age a then x else a) xs

age[a, b] = toInt b
age[a] = 0
age[] = 0

toInt :: String -> Int
toInt = read

doWork csv = (print.findOldest.tail) csv

handleError csv = putStrLn "error parsing"

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


    putStrLn "read Csv"

    let csvFilename = "input.csv"
    csvInput <- catch (readFile csvFilename) (\e -> print(e::SomeException) >> return "")

    let csv = parseCSV csvFilename csvInput

    either handleError doWork csv

    putStrLn "read Json"

    putStrLn "End, Haskell!"
        
