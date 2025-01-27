#! /usr/bin/env nix-shell
#! nix-shell -p "haskellPackages.ghcWithPackages (p: with p; [base text])" -i runghc

{-# LANGUAGE OverloadedStrings #-}

import Data.Text (Text, pack, unpack)

helloWorld :: Text
helloWorld = "Hello, World!"

main :: IO ()
main = print $ unpack helloWorld
