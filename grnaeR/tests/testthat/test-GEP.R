library('grnaeR')
library('testthat')
library(magrittr)
library(dplyr)
library(tidyverse)
library(enrichplot)
library(ggpubr)
library(MASS)
library('ggplot2')
library("pheatmap")
library("RColorBrewer")
library('DESeq2')
library('AnnotationDbi')
library('org.Hs.eg.db')

#import the test data
library(DOSE)
data(geneList)


test_that('check the generation of enrichResult',{
  #check the edge cases where the input genelist is empty
  empty_genelist = list()
  type_check= typeof(filter_genelist(geneList,2))
  expect_equal(type_check,"S4")
  expect_equal(filter_genelist(empty_genelist,3),"the gene List is empty, please put in the correct geneList")
})
#

edo <- filter_genelist(geneList,2)

test_that('check the generation of barplot',{
  expect_identical(show_barplot(edo,showCategory_num = 20,"barplot.png"), "bar plot generated")
})

#Is it ok that we get several warning cases but the code itself works
test_that('check the generation of dotplot',{
  expect_equal(show_dotplot(edo,showCategory_num=30,dotpf_name = 'combined_dotplot.png'),"successfully generated dotplot")
})


test_that('check the generation of gene network',{
  expect_equal(develop_Gene_Network(edo,geneList,GeneNetp_name = "Gene_Network.png"),"successfully generated gene Network")
})


#test case
test_that('integration test for find_DEG',{
  dir = '/Users/jesi/Documents'
  file = '/Users/jesi/Documents/CRS_34v0.txt'
  readcount = load_data(dir,file)
  check_totalcov_quality(readcount)
  check_genecovered_quality(readcount)
  condition_vector = c(c(rep('CRS',4)),c(rep('noCRS',5)))
  type_vector = c(colnames(readcount))
  dds = load_data_for_DESeq2(file,condition_vector,type_vector)
  normalized_dds = normalize_dataset(dds)
  check_sample_distance(normalized_dds)
  select_DEGs = select_DEG(dds = dds,filter_thresh = 0,log2_fc = log(1.5,2), padj=0.05)

  expect_equal(calculate_RPKM(readcount),"the exonlength should be contained in provided file to calculate RPKM")
  expect_equal(class(dds)[1],"DESeqDataSet")
})

