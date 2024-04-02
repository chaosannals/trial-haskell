{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Main where

import Control.Monad
import Data.Int
import Data.Monoid
import Data.String
import Data.Text (Text)
-- import Data.Scientific (Scientific)
import Database.Beam
import Database.Beam.Backend.SQL.BeamExtensions
import Database.Beam.Sqlite
import Database.SQLite.Simple

import SqliteDemo.Simple

main :: IO ()
main = do
  conn <- open "beamdemo.db"
  runBeamSqliteDebug putStrLn {- for debug output -} conn $
    runInsert $
      insert (myUsers myDb) $
        insertValues
          [ User 1 "james@example.com" "James" "Smith" "b4cc344d25a2efe540adbf2678e2304c" {- james -},
            User 2 "betty@example.com" "Betty" "Jones" "82b054bd83ffad9b6cf8bdb98ce3cc2f" {- betty -},
            User 3 "sam@example.com" "Sam" "Taylor" "332532dcfaa1cbf61e2a266bd723612c" {- sam -}
          ]
  putStrLn "insert"
