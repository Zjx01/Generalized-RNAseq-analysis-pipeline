# generalized RNAseq analysis pipeline (under development)

we aim to develop a general RNA-seq analysis workflow, starting from differential gene expressions detection to follow-up pathway analysis, providing a one-button pipieline and easing the tedious procedures. A major prominent part of the project is that the pipeline provides various visualization methods in gene enrichment and pathway analysis, contributing to the comprehension of the underlying biological pathogenesis. 



The test case we use for find_DEG is provided in example_Data is the baseline CRS RNASeq raw count data from Tewari Munnesh Lab, it is expected that the package could return the differentially expressed genes between two groups while given the basic study design information indluding condition_vector and type_vector and gene filtering and selection threshold. The test data used for the downstream analysis is from package DOSE using data(geneList), and it is expected that the package should generate plots like gene network plot to help visualize the interactome between target genes.


Detailed Instruction on the project implementation can be viewed in the happy_path_implementation markdown.
Linkage: https://github.com/Zjx01/Generalized-RNAseq-analysis-pipeline/blob/main/happy_path_RMarkdown.html






