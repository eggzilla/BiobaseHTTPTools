{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE Arrows #-}
{-# LANGUAGE RecordWildCards #-}
module Main where

import System.Console.CmdArgs
import Biobase.Entrez.HTTP
import qualified Data.ByteString.Lazy.Char8 as B
import Biobase.Fasta.Types
import Biobase.Fasta.Streaming

options :: Options
data Options = Options
  { geneId :: Int,
    geneStart :: Int,
    geneStop :: Int
  } deriving (Show,Data,Typeable)


options = Options
  { geneId = def &= name "g" &= help "Gene id",
    geneStart = def &= name "s" &= help "Gene start",
    geneStop = def &= name "t" &= help "Gene stop"
  } &= summary ("Fetchsequence ") &= help "Florian Eggenhofer - 2018" &= verbosity

efetchSequence :: Int -> Int -> Int ->  IO ()
efetchSequence _geneId _geneStart _geneStop = do
  let eutilProgram = Just "efetch"
  let database = Just "nucleotide"
  let queryString = "id=" ++ show _geneId ++ "&seq_start=" ++ show _geneStart ++ "&seq_stop=" ++ show _geneStop ++ "&rettype=fasta"
  let entrezQuery = EntrezHTTPQuery eutilProgram database queryString
  result <- entrezHTTP entrezQuery
  let parsedFasta = parseFasta (B.pack result)
  print (fastaHeader (head (parsedFasta)))
  print (B.unpack (fastaSequence (head (parsedFasta))))

main :: IO ()
main = do
  Options{..} <- cmdArgs options
  efetchSequence geneId geneStart geneStop
