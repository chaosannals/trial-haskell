{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main where

import Data.Aeson
import qualified Data.ByteString.Lazy as B
import GHC.Generics

data Mathematician = Mathematician {
    name :: String,
    born :: Int,
    gander :: Maybe String
} deriving Generic

instance FromJSON Mathematician where
    parseJSON (Object v) = Mathematician
        <$> (v .: "name")
        <*> (v .: "born")
        <*> (v .:? "gender")

greet m = (show.name) m ++ " was born in the year " ++ (show.born) m

main :: IO ()
main = do
    putStrLn "Hello, Haskell!"

    putStrLn "read Json"

    jsonInput <- B.readFile "input.json"
    let mm = decode jsonInput :: Maybe Mathematician
    case mm of
        Nothing -> print "error json parsing"
        Just m -> (putStrLn.greet) m

    putStrLn "End, Haskell!"