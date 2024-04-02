module Main where

import Database.SQLite.Simple
import SqliteDemo.Simple

main :: IO ()
main = do
  conn <- open "beamdemo.db"
  putStrLn "select"