{-# LANGUAGE OverloadedStrings #-}

module Text.Gen(
    Gen,
    runGen,
    getIndent,
    setIndent,
    getIndentChar,
    genNewLine,
    genLine
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

setIndent :: Int -> Gen ()
setIndent i = set i

getIndentChar :: Gen Text
getIndentChar = ask

genNewline :: Gen ()
genNewline = write "\n"

genLine :: Text -> Gen ()
genLine txt = do
    ind <- getIndent
    indchar <- getIndentChar
    for ind \i -> tell indchar
    genNewline
    where
        for :: (Integeral i,Monad m) => i -> (i -> m a) -> m ()
        for i f = if i != 0 then do
            f i
            for (i-1) f
        else
            return ()
    
    

