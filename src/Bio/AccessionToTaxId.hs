{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE Arrows #-}
{-# LANGUAGE RecordWildCards #-}
module Main where
    
import System.Console.CmdArgs
import Bio.EntrezHTTP
import Bio.Sequence.Fasta
import qualified Data.ByteString.Lazy.Char8 as B
import Text.XML.HXT.Core

options :: Options
data Options = Options
  { accession :: String
  } deriving (Show,Data,Typeable)


options = Options
  { accession = def &= name "a" &= help "NCBI accession number, e.g NC_000913"
  } &= summary ("AccessionToTaxId ") &= help "Florian Eggenhofer - 2018" &= verbosity

-- | gets all subtrees with the specified tag name
atTag :: ArrowXml a =>  String -> a XmlTree XmlTree
atTag tag = deep (isElem >>> hasName tag)

accessionToTaxId :: String -> IO ()
accessionToTaxId _accession = do
  let program = Just "esummary"
  let database = Just "nucleotide" 
  let queryString = "id=" ++ _accession
  let entrezQuery = EntrezHTTPQuery program database queryString 
  result <- entrezHTTP entrezQuery
  let summary = head (readEntrezSummaries result)
  print summary

main = do
  Options{..} <- cmdArgs options  
  accessionToTaxId accession

