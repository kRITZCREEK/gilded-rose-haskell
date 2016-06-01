module Main where

import Prelude
import Data.List.Lazy as Lazy
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.List ((..), zip, fromFoldable, List)
import Data.Traversable (for_)
import Data.Tuple (Tuple(Tuple))
import GildedRose (GildedRose, Item(..), updateQuality)

inventories :: Int -> List GildedRose
inventories n =
  fromFoldable
  <<< Lazy.take n
  <<< Lazy.iterate updateQuality
  $ initialInventory

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  let n = 5
      inventoriesWithDay = inventories (n + 1) `zip` (0 .. n)
  for_ inventoriesWithDay printUpdate

printUpdate
  :: forall e
  . Tuple GildedRose Int
  -> Eff (console :: CONSOLE | e) Unit
printUpdate (Tuple items day) = do
  log  ("-------- day " <> show day <> " --------")
  log "name, sellIn, quality"
  for_ items (log <<< show)
  log ""

initialInventory :: GildedRose
initialInventory = fromFoldable
  [ Item "+5 Dexterity Vest"                          10  20
  , Item "Aged Brie"                                   2   0
  , Item "Elixir of the Mongoose"                      5   7
  , Item "Sulfuras, Hand of Ragnaros"                  0  80
  , Item "Sulfuras, Hand of Ragnaros"                (-1) 80
  , Item "Backstage passes to a TAFKAL80ETC concert"  15  20
  , Item "Backstage passes to a TAFKAL80ETC concert"  10  49
  , Item "Backstage passes to a TAFKAL80ETC concert"   5  49
  -- this conjured item does not work properly yet
  , Item "Conjured Mana Cake"                          3   6
  ]
