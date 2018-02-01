module Test.Main where

import Prelude

import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import GildedRose (Item(..), updateQuality)
import Test.Unit (suite, test)
import Test.Unit.Assert as Assert
import Test.Unit.Console (TESTOUTPUT)
import Test.Unit.Main (runTest)

main ∷ ∀ e. Eff (console ∷ CONSOLE, testOutput ∷ TESTOUTPUT, avar ∷ AVAR | e) Unit
main = runTest do
  suite "Gilded Rose" do
    test "single transition" do
      Assert.equal 1 1
