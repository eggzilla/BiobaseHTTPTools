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
  } &= summary ("GeneIdToUniProtId") &= help "Florian Eggenhofer - 2018" &= verbosity

geneIdToUniProtId :: T.Text -> IO ()
geneIdToUniProtId _geneIds = do
  let geneIdList = T.splitOn "," _geneIds
  uniprotIds <- requestUniProtWithGeneIds geneIdList
  mapM putStrLn uniprotIds

main = do
  Options{..} <- cmdArgs options
  geneIdToUniProtId geneIds
