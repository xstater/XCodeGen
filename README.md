# XCodeGen
a simple pattern code generator written in Haskell

## example1
```haskell
{-# LANGUAGE OverloadedStrings #-}

import Text.Gen
import Text.Gen.C

main :: IO ()
main = do
    putStrLn $ unpack $ runGen "    " $ do
        include' "stdio.h"
        define "PI" "3.1415926" 
        newline
        enum "Index" $ raw `fmap` ["first","second","third","forth","fifth"] 
        newline 
        struct "Fuck" $ do
           statement $ var int "a"
           statement $ var char "c"
        newline
        function char "nmsl" [var char "asd",var int "abc"]
        cblock $ do
            statement $ do
                raw "asd"
                binaryOp "=" $ do
                    raw "asd"
                    binaryOp "+" $ raw "abc"
            statement $ raw "return asd"
        newline
        function int "main" [var int "argc",var char "argv[]"]
        cblock $ do
            statement $ call "nmsl" [char' 'a',number 123]
            statement $ call "printf" [call "nmsl" [char' 'b',number 222]]
            statement $ raw "return 0"
```
output:
```c++
#include "stdio.h"
#define PI 3.1415926

enum Index{first,second,third,forth,fifth};

struct Fuck{
    int a;
    char c;
};

char nmsl(char asd,int abc){
    asd = asd + abc;
    return asd;
}

int main(int argc,char argv[]){
    nmsl('a',123);
    printf(nmsl('b',222));
    return 0;
}
```

## example2 
```haskell
{-# LANGUAGE OverloadedStrings #-}

import Text.Gen
import Text.Gen.Json

main :: IO ()
main = do
    putStrLn $ unpack $ runGen "    " $ do
        object $ do
            lineComma $ value "name" $ string "john"
            lineComma $ value "age" $ number 3
            lineComma $ value "ids" $ array $ string `fmap` ["asd","ads"]
            line $ value "info" $ object $ do
                lineComma $ value "asd" $ string "asd"
                lineComma $ value "bl" $ bool False
                line $ value "asdsa" $ string "asd"
```
output:
```json
{
    "name":"john",
    "age":3,
    "ids":["asd","ads"],
    "info":{
        "asd":"asd",
        "bl":false,
        "asdsa":"asd"
    }
}
```