{-# LANGUAGE OverloadedStrings #-}

module Text.Gen.C(
    int,
    uint,
    short,
    ushort,
    long,
    ulong,
    longlong,
    ulonglong,
    unsigned,
    char,
    uchar,
    float,
    double,
    void,

    statement,
    var,
    function,
    cblock,
    number,
    char',
    string,
    call,
    return',
    binaryOp,
    if',
    else',
    while,
    for,
    include,
    include',
    define,
    struct,
    union,
    enum
)where

import Data.Text hiding (split)
import Text.Gen 

--some userful constant
int :: Text 
int = "int"

uint :: Text 
uint = "unsigned int"

short :: Text
short = "short"

ushort :: Text
ushort = "unsigned short"

long :: Text
long = "long"

ulong :: Text
ulong = "unsigned long"

longlong :: Text
longlong = "long long"

ulonglong :: Text
ulonglong = "unsigned long long"

unsigned :: Text
unsigned = "unsigned" 

char :: Text
char = "char"

uchar :: Text
uchar = "unsigned char"

float :: Text
float = "float"

double :: Text
double = "double"

void :: Text
void = "void"

--functions 

statement :: Gen () -> Gen ()
statement act = do
    indent
    act
    raw ";\n"

var :: Text -> Text -> Gen ()
var typ name = do
    raw $ typ `append` (' ' `cons` name)

function :: Text -> Text -> [Gen ()] -> Gen ()
function rettype name args = do
    var rettype name
    pair "(" ")" $ split "," args

cblock :: Gen () -> Gen ()
cblock acts = block "{\n" "}\n" acts

number :: (Show n,Num n) => n -> Gen ()
number num = raw $ pack $ show num

char' :: Char -> Gen ()
char' ch = pair "\'" "\'" $ raw $ singleton ch

string :: Text -> Gen ()
string str = pair "\"" "\"" $ raw str

call :: Text -> [Gen ()] -> Gen ()
call name args = pair (name `append` "(") ")" $ split "," args

return' :: Gen () -> Gen ()
return' act = statement $ do
    raw "return "
    act

binaryOp :: Text -> Gen () -> Gen ()
binaryOp op act = do
    raw " "
    raw op
    raw " "
    act

if' :: Gen () -> Gen ()
if' pred = pair "if(" ")" pred

else' :: Gen ()
else' = raw "else"

for :: [Gen ()] -> Gen ()
for (a:b:c:xs) = do
    pair "for(" ")" $ do
        a
        raw ";"
        b
        raw ";"
        c

while :: Gen () -> Gen ()
while pred = pair "while(" ")" pred

--dowhile

include :: Text -> Gen ()
include file = do
    raw "#include "
    pair "<" ">" $ raw file
    newline 

include' :: Text -> Gen ()
include' file = do
    raw "#include "
    string file
    newline

define :: Text -> Text -> Gen ()
define name context = do
    raw "#define "
    raw name
    raw " "
    raw context
    newline

--

struct :: Text -> Gen () -> Gen ()
struct name act = do
    raw "struct "
    raw name
    block "{\n" "};" act
    newline

union :: Text -> Gen () -> Gen ()
union = struct

enum :: Text -> [Gen ()] -> Gen ()
enum name acts = do
    raw "enum "
    raw name
    pair "{" "};" $ split "," acts
    newline

