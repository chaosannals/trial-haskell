{-# LANGUAGE OverloadedStrings #-}

module Main where

import Database.Beam
import Database.Beam.Sqlite
import Database.SQLite.Simple
import SqliteDemo.Simple
import Control.Applicative
import Control.Monad (forM_)

data UserRow = UserRow Int String String String String deriving(Show)
instance FromRow UserRow where
  fromRow = UserRow <$> field <*> field <*> field <*> field <*> field

main :: IO ()
main = do
  putStrLn "select"
  conn <- open "beamdemo.db"
  -- sqlite-simple 裸语句
  r <- query_ conn "SELECT * FROM User" :: IO [UserRow]
  mapM_ print r

  -- beam
  putStrLn "beam select"
  
  -- 不打印 SQL
  users <- runBeamSqlite conn $
    runSelectReturningList $ select $ all_ (myUsers myDb)
  
  -- 打印SQL
  users2 <- runBeamSqliteDebug putStrLn conn $
    runSelectReturningList $ select $
      limit_ 2 $
      filter_ (\u -> (userEmail u `like_` "%@%") &&. (userId u >=. 0)) $
      all_ (myUsers myDb)

  putStrLn "users: "
  forM_ users $ \row ->
    putStrLn $ show row

  putStrLn "users2: "
  forM_ users2 $ \row ->
    putStrLn $ show row
  putStrLn "end."