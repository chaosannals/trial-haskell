{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty
import System.FilePath ((</>))
import App

(>|<) :: IO ()
(>|<) = putStrLn ">_<"

main :: IO ()
main = do
    (>|<)
    putStrLn $ "start at port: " ++ show port
    app <- createApp
    scotty port $ do
        get "/" $ nested app

        get "/word/:word" $ do
            beam <- pathParam "word"
            html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
    where
        port = 44444
