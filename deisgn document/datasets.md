Brief description of dataset used for the project

1. Input data format for generalized RNA-seq pipeline can be  SRR accession list txt downloaded from NCBI or SRR numbers using prefetch command. 
2. For downstream analysis geneList object is required for gene enrichment visualization.

the test case we use is for function sra_to_fastq is SRR5815077 and SRR5815077 (single-end sequenced RNA Seq data) you can download them with prefetch or mannually download them. The test data used for the downstream analysis is from package DOSE using data(geneList) 

Data downloaded comandline:
prefetch SRR5815077 SRR5815077
