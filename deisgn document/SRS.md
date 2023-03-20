Software requirement specification   

For:
By: Jingxian Zhao

# 1.	Introduction 
we aim to develop a general RNA-seq analysis workflow from bottom to up, starting from data 
downloading to differential gene expressions and follow-up pathway analysis, providing a reference 
manual and easing the tedious procedures.

# 2.	Overall description
Input: 
1. Input data format for generalized RNA-seq pipeline should be RNAseq raw count data to find the differential expressed genes.
2. For downstream analysis geneList object is required for gene enrichment visualization.

Output: RNA data analysis result including gene count, differentially expressed genes and pathway analysis if available.

# 3.	Requirement
Input data format for generalized RNA-seq pipeline:
RNAseq raw count data 
 
For downstream analysis geneList containing fold change level with the respective gene ID as colname name for each gene is required.
