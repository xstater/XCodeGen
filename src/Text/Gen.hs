{-# LANGUAGE OverloadedStrings #-}

module Text.Gen(
    Gen,
    runGen,
    raw,
    line,
    newline,
    indent,
    pair,
    split,
    block
)where

import Control.Monad
import Control.Monad.Writer.Lazy
import Control.Monad.State.Lazy
import Control.Monad.Reader
import Data.Monoid
import Data.Text hiding (split)

--State is indent
--Reader is indent character(Text,u can use 4 spaces to replace tab)
--Writer is Raw string
type Gen a = StateT Int (ReaderT Text (Writer Text)) a

for :: (Integral i,Monad m) => i -> (i -> m a) -> m ()
for i f = 
    if i /= 0 then do
        f i
        for (i-1) f
    else
        return ()


runGen :: Text -> Gen () -> Text
runGen indc g =
    let r = evalStateT g 0
        w = runReaderT r indc
    in execWriter w

raw :: Text -> Gen ()
raw = tell

newline :: Gen ()
newline = tell "\n"

line :: Gen () -> Gen ()
line act = do
    indent
    act
    newline

indent :: Gen ()
indent = do
    ind <- get
    indc <- ask
    for ind $ \_ -> tell indc

pair :: Text -> Text -> Gen () -> Gen ()
pair left right act = do
    tell left
    act
    tell right

split :: Text -> [Gen ()] -> Gen ()
split _ [] = return ()
split _ (x:[]) = x
split t (x:xs) = do
    x
    tell t
    split t xs

block :: Text -> Text -> Gen () -> Gen ()
block front back act = do
    raw front
    ind <- get
    put $ ind + 1
    act
    put $ ind
    indent
    raw back

