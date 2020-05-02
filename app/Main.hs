module Main where

import Text.Gen

main :: IO ()
main = do
    print $ runGen "aa" do
        genLine "nmsl"
