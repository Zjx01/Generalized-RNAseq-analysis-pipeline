Software requirement specification   

For:
By: Jingxian Zhao

# 1.	Introduction 
we aim to develop a general RNA-seq analysis workflow from bottom to up, starting from data 
downloading to differential gene expressions and follow-up pathway analysis, providing a reference 
manual and easing the tedious procedures.

# 2.	Overall description
Input:  SRR accession list in a txt format or SRR numbers, the input depends on where you want to starts with 

Output: RNA data analysis result including gene count, differentially expressed genes and pathway analysis if available.

# 3.	Requirement
Input data format for generalized RNA-seq pipeline:
SRR accession list txt downloaded from NCBI or SRR numbers 

For downstream analysis geneList containing fold change level with the respective gene ID as colname name for each gene is required.
