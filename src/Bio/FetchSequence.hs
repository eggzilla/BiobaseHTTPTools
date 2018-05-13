{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE Arrows #-}
{-# LANGUAGE RecordWildCards #-}
module Main where
    
import System.Console.CmdArgs
import Bio.EntrezHTTP
import Bio.Sequence.Fasta
import qualified Data.Map as M
import qualified Data.ByteString.Lazy.Char8 as B
import Bio.Core.Sequence

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
  let program = Just "efetch"
  let database = Just "nucleotide" 
  let queryString = "id=" ++ show _geneId ++ "&seq_start=" ++ show _geneStart ++ "&seq_stop=" ++ show _geneStop ++ "&rettype=fasta"
  let entrezQuery = EntrezHTTPQuery program database queryString 
  result <- entrezHTTP entrezQuery
  let parsedFasta = (mkSeqs . B.lines) (B.pack result)
  print (seqid (head (parsedFasta)))
  print (toStr (seqdata (head (parsedFasta))))

main = do
  Options{..} <- cmdArgs options  
  efetchSequence geneId geneStart geneStop

