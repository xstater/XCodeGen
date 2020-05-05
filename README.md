# XCodeGen
a simple pattern code generator written in Haskell

## example
```haskell
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