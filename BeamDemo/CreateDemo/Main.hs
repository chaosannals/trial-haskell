module Main where

import Database.SQLite.Simple

main :: IO ()
main = do
  conn <- open "beamdemo.db"
  putStrLn ""