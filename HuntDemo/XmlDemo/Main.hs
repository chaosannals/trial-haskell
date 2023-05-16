module Main where

import Text.XML.HXT.Core

main :: IO ()
main = do
    putStrLn "Hello, Haskell!"

    input <- readFile "input.xml"

    names <- runX $ readString [withValidate no] input
        //> hasName "name"
        //> getText

    hideNames <- runX $ readString [withValidate no] input
        //> hasAttr "hide"
        //> hasName "name"
        //> getText

    print names
    print hideNames

    putStrLn "End, Haskell!"