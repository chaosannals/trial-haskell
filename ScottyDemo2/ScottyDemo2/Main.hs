{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty
import System.FilePath ((</>))

main :: IO ()
main = do
    putStrLn $ "start at port: " </> show port
    scotty port $ do
        get "/word/:word" $ do
            beam <- pathParam "word"
            html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
    where
        port = 44444
