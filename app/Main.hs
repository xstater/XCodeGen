{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Text
import System.Environment
import Options.Applicative
import Data.Semigroup

data AppArgs = AppArgs {
    input :: String,
    output :: String,
    showHelp :: Bool,
    showVersion :: Bool
}

appArgs :: Parser AppArgs
appArgs = AppArgs <$> 
    strOption (
        long "input" <>
        short 'i' <>
        metavar "FILE" <>
        value "" <>
        help "The input file"
    ) <*> strOption (
        long "output" <>
        short 'o' <>
        metavar "FILE" <>
        value "a.txt" <>
        help "The output file"
    ) <*> switch (
        long "help" <>
        short 'h' <>
        help "Show help information"
    ) <*> switch (
        long "version" <>
        short 'v' <>
        help "Show version number"
    )

printHelpInfo :: IO ()
printHelpInfo = do
    putStrLn "XCodeGen - a pattern code generator"
    putStrLn "Usage: xcg [-i|--input FILE] [-o|--output FILE] [-h|--help] [-v|--version]"
    putStrLn "Arguments:"
    putStrLn "\t-input\t-i:Specify the input file"
    putStrLn "\t-output\t-o:Specify the output file"
    putStrLn "\t-help\t-h:Show help information"

printVersion :: IO ()
printVersion = putStrLn "XCodeGen:version 0.0.1"

app :: AppArgs -> IO ()
app (AppArgs _ _ True _) = printHelpInfo
app (AppArgs _ _ _ True) = printVersion
app (AppArgs "" _ _ _) = do
    putStrLn "Fatal Error:No input file"
    putStrLn "Use \"xcg -h\" to show help information"
app (AppArgs inputFile outputFile _ _) = do
    print inputFile
    print outputFile

main :: IO ()
main = do
    appargs <- execParser $ info (appArgs <**> helper) (
        fullDesc <>
        progDesc "Generate pattern code to any file" <>
        header "XCodeGen - a simple pattern code generator")    
    app appargs
