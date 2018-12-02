{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.Console.CmdArgs
import Biobase.Ensembl.HTTP
import Data.List
import qualified Data.Text as T

options :: Options
data Options = Options
  { geneIds :: T.Text
  } deriving (Show,Data,Typeable)

options = Options
  { geneIds = def &= name "g" &= help "Ensembl gene ids (or NCBI locus tags) comma separated, e.g b0001,b0825"
  } &= summary ("GeneIdToGOTerms") &= help "Florian Eggenhofer - 2018" &= verbosity

geneIdToGOTerms :: T.Text -> IO ()
geneIdToGOTerms _geneIds = do
  let geneIdList = T.splitOn "," _geneIds
  idsGoTermsPair <- requestGOTermsWithGeneIds geneIdList
  let output = map (\(a,b) -> a `T.append` (T.intercalate (T.pack ",") b) idsGoTermsPair
  mapM putStrLn output

main = do
  Options{..} <- cmdArgs options
  geneIdToGOTerms geneIds
