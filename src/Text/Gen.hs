{-# LANGUAGE OverloadedStrings #-}

module Text.Gen(
    Gen,
    runGen,
    incIndent,
    decIndent,
    getIndent,
    genIndent,
    getIndentChar,
    genNewline,
    genLine,
    genRaw,
    genPair
)where

import Control.Monad
import Control.Monad.Writer.Lazy
import Control.Monad.State.Lazy
import Control.Monad.Reader
import Data.Monoid
import Data.Text

--State is indent
--Reader is indent character(Text,u can use 4 spaces to replace tab)
--Writer is Raw string
type Gen a = StateT Int (ReaderT Text (Writer Text)) a

runGen :: Text -> Gen () -> Text
runGen indc g =
    let r = evalStateT g 0
        w = runReaderT r indc
    in execWriter w
        
getIndent :: Gen Int
getIndent = get

incIndent :: Gen ()
incIndent = do
    ind <- get
    put $ ind + 1

decIndent :: Gen ()
decIndent = do
    ind <- get
    put $ ind - 1

getIndentChar :: Gen Text
getIndentChar = ask

genNewline :: Gen ()
genNewline = tell "\n"

for :: (Integral i,Monad m) => i -> (i -> m a) -> m ()
for i f = if i /= 0 then do
    f i
    for (i-1) f
else
    return ()

genIndent :: Gen ()
genIndent = do
    ind <- getIndent
    indchr <- getIndentChar
    for ind $ \_ -> tell indchr

genRaw :: Text -> Gen ()
genRaw txt = do
    tell txt

genLine :: Text -> Gen ()
genLine txt = do
    genIndent
    tell txt
    genNewline

    
genPair:: Text -> Text -> Gen () -> Gen ()
genPair front last gen = do
    tell front
    incIndent
    gen
    decIndent
    tell last
     
