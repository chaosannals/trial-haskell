module Main where

import Text.XML.HXT.Core
import Data.List.Split(chunksOf)

findBiggest :: [[String]] -> [String]
findBiggest [] = []
findBiggest items = foldl1 (\a x -> if capacity x > capacity a then x else a) items

capacity [a, b, c] = toInt c
capacity _ = -1

toInt :: String -> Int
toInt = read

main :: IO ()
main = do
    putStrLn "Hello, Haskell!"

    input <- readFile "input.html"

    texts <- runX $ readString [withParseHTML yes, withWarnings no] input
        //> hasName "li"
        //> hasName "span"
        //> getText

    print texts

    let rows = chunksOf 3 texts

    print rows

    print $ findBiggest rows

    putStrLn "End, Haskell!"