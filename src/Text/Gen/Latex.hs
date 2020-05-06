{-# LANGUAGE OverloadedStrings #-}

module Text.Gen.Latex(
    aligned,
    frac,
    newline_,
    sqrt_
)where

import Data.Text
import Text.Gen

aligned :: Gen () -> Gen ()
aligned act = block "\\begin{aligned}\n" "\\end{aligned}\n" act

frac :: Gen () -> Gen () -> Gen ()
a `frac` b = do
    raw "\\frac{"
    a
    raw "}{"
    b
    raw "}"

newline_ :: Gen ()
newline_ = raw "\\\\\n"

sqrt_ :: Gen () -> Gen ()
sqrt_ act = pair "\\sqrt{" "}" act

