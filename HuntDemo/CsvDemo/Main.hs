module Main where

import Control.Exception (catch, SomeException)
import Text.CSV

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

    putStrLn "read Csv"

    let csvFilename = "input.csv"
    csvInput <- catch (readFile csvFilename) (\e -> print(e::SomeException) >> return "")

    let csv = parseCSV csvFilename csvInput

    either handleError doWork csv

    putStrLn "End, Haskell!"