{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE Arrows #-}
{-# LANGUAGE RecordWildCards #-}
module Main where

import System.Console.CmdArgs
import Biobase.Entrez.HTTP
import Data.List
import Data.Maybe

options :: Options
data Options = Options
  { accession :: String
  } deriving (Show,Data,Typeable)

options = Options
  { accession = def &= name "a" &= help "NCBI accession number, e.g NC_000913"
  } &= summary ("AccessionToTaxId ") &= help "Florian Eggenhofer - 2018" &= verbosity

accessionToTaxId :: String -> IO ()
accessionToTaxId _accession = do
  let _program = Just "esummary"
  let _database = Just "nucleotide"
  let queryString = "id=" ++ _accession
  let entrezQuery = EntrezHTTPQuery _program _database queryString
  result <- entrezHTTP entrezQuery
  let _summary = head (readEntrezSummaries result)
  let taxIdItem = find (\a -> itemName a == "TaxId") (summaryItems (head (documentSummaries _summary)))
  putStrLn (itemContent (fromJust taxIdItem))

main :: IO ()
main = do
  Options{..} <- cmdArgs options
  accessionToTaxId accession
