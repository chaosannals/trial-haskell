{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module SqliteDemo.Simple
  -- ( UserT,
  --   User,
  --   BookT,
  --   Book,
  --   MyDbT,
  --   myDb,
  --   myUsers,
  --   myBooks,
  -- )
where

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

-- User

data UserT f
  = User
  { userId :: Columnar f Int32,
    userEmail :: Columnar f Text,
    userFirstName :: Columnar f Text,
    userLastName :: Columnar f Text,
    userPassword :: Columnar f Text
  }
  deriving (Generic)

instance Beamable UserT

type User = UserT Identity

type UserId = PrimaryKey UserT Identity

instance Table UserT where
  data PrimaryKey UserT f = UserId (Columnar f Int32)
    deriving (Generic)
  primaryKey = UserId . userId

instance Beamable (PrimaryKey UserT)

-- Book

data BookT f = Book
  { bookId :: Columnar f Int32,
    bookName :: Columnar f Text
  }
  deriving (Generic)

instance Beamable BookT

type Book = BookT Identity

type BookId = PrimaryKey BookT Identity

instance Table BookT where
  data PrimaryKey BookT f = BookId (Columnar f Int32)
    deriving (Generic)
  primaryKey = BookId . bookId

instance Beamable (PrimaryKey BookT)

-- 数据库
data MyDbT f = MyDbT
  { myUsers :: f (TableEntity UserT),
    myBooks :: f (TableEntity BookT)
  }
  deriving (Generic)

instance Database be MyDbT

myDb :: DatabaseSettings be MyDbT
myDb =
  defaultDbSettings
    `withDbModification` ( dbModification
                             { -- 默认表名是 users 这里指定表名为 User
                               myUsers = setEntityName "User",
                               -- 不知道这个 modify 意义何在，没有版本号的迁移。。。
                               -- 旧示例，已经是不能用的代码，这个库改了方式，没改部分示例 <> modifyTableFields (User "UserId" "Title" (UserId "UserId"))
                               myBooks =
                                 setEntityName "Book"
                                   -- 新的写法
                                   <> modifyTableFields
                                     tableModification
                                       { bookName = fieldNamed "number"
                                       }
                             }
                         )
