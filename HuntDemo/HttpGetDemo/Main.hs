module Main where

import Text.XML.HXT.Core
import Text.HandsomeSoup

main :: IO ()
main = do
    putStrLn "Hello, Haskell!"

    let doc = fromUrl "http://baidu.com"

    links <- runX $ doc >>> css "a" ! "href"

    print links

    putStrLn "End, Haskell!"
    