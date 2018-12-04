{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE RecordWildCards #-}
module Main where

import System.Console.CmdArgs
import Biobase.Ensembl.HTTP
--import Data.List
import qualified Data.Text as T

options :: Options
data Options = Options
  { geneIds :: String
  } deriving (Show,Data,Typeable)

options = Options
  { geneIds = def &= name "g" &= help "Ensembl gene ids (or NCBI locus tags) comma separated, e.g b0001,b0825"
  } &= summary ("GeneIdToUniProtId") &= help "Florian Eggenhofer - 2018" &= verbosity

geneIdToUniProtId :: T.Text -> IO ()
geneIdToUniProtId geneIdsText = do
  let geneIdList = T.splitOn "," geneIdsText
  uniprotIds <- requestUniProtWithGeneIds geneIdList
  let output = map (\(a,b) -> a `T.append` (T.pack "\t") `T.append` b) uniprotIds
  mapM_ (putStrLn . T.unpack) output

main :: IO ()
main = do
  Options{..} <- cmdArgs options
  geneIdToUniProtId (T.pack geneIds)
