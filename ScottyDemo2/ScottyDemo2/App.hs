{-# LANGUAGE OverloadedStrings #-}

module App where

import Network.Wai
import Web.Scotty

createApp :: IO Application
createApp = scottyApp $ do

    get "/" $ do
        html $ mconcat ["<h1>Scotty, beam me up!</h1>"]