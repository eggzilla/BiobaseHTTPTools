# BiobaseHTTPTools

[![Hackage](https://img.shields.io/hackage/v/BiobaseHTTPTools.svg)](https://hackage.haskell.org/package/BiobaseHTTPTools) [![Build Status](https://travis-ci.org/eggzilla/BiobaseHTTPTools.svg)](https://travis-ci.org/eggzilla/BiobaseHTTPTools)
=============

Biobase Tool utilizes functions from the BiobaseHTTP library to provide
several commandline utilities for routine-tasks with taxonomy data, sequence retrieval, GO Term retrieval.

BiobaseHTTPTools can be install via the Haskell package management system:

    cabal install BiobaseHTTPTools

Currently following Tools are included and linked with their usage instructions:

### [FetchSequence](fetchsequence.md)
Retrieves sequences in fasta format

### [AccessionToTaxId](AccessionToTaxId.md)
Converts NCBI accession number to taxonomy id

### [GeneIdToGOTerms](GeneIdToGOTerms.md)
Retrieve GOterms for a Ensembl GeneId

### [GeneIdToUniProtId](GeneIdToUniProtId.md)
Retrieves UniProtId for a Ensembl GeneId
