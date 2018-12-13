{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE RecordWildCards #-}
module Main where

import System.Console.CmdArgs
import Biobase.Ensembl.HTTP
import Data.List
import qualified Data.Text as T

options :: Options
data Options = Options
  { geneIds :: String
  } deriving (Show,Data,Typeable)

options = Options
  { geneIds = def &= name "g" &= help "Ensembl gene ids (or NCBI locus tags) comma separated, e.g b0001,b0825"
  } &= summary ("GeneIdToGOTerms") &= help "Florian Eggenhofer - 2018" &= verbosity

geneIdToGOTerms :: T.Text -> IO ()
geneIdToGOTerms geneIdsText = do
  let geneIdList = T.splitOn "," geneIdsText
  idsGoTermsPair <- requestGOTermsWithGeneIds geneIdList
  let output = map (\(a,b) -> a `T.append` (T.pack "\t") `T.append` (T.intercalate (T.pack ",") b)) idsGoTermsPair
  mapM_ (putStrLn . T.unpack) output

main :: IO ()
main = do
  Options{..} <- cmdArgs options
  geneIdToGOTerms (T.pack geneIds)
