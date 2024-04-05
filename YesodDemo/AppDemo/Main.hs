{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}

module Main where

import Yesod.Core
import Routes

instance Yesod App
instance YesodDispatch App

getHomeR :: Handler String
getHomeR = return "Hello"

main :: IO ()
main = do
    putStrLn "start"
    warp 44444 App
