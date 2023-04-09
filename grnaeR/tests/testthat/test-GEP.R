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
  expect_identical(typeof(show_barplot(edo,showCategory_num = 20)), "list")
})

#Is it ok that we get several warning cases but the code itself works
test_that('check the generation of dotplot',{
  expect_equal(typeof(show_dotplot(edo,showCategory_num=30)),"list")
})


test_that('check the generation of gene network',{
  expect_equal(typeof(develop_Gene_Network(edo,geneList)),"list")
})



file = paste(system.file('extdata', package = "grnaeR"),system.file('extdata', package = "grnaeR")|>list.files(),sep = '/')
readcount = load_data(file)

test_that('check calculate_RPKM',{
  expect_equal(calculate_RPKM(readcount),"the exonlength should be contained in provided file to calculate RPKM")
})


#test case
test_that('integration test for find_DEG',{
  condition_vector = c(c(rep('CRS',4)),c(rep('noCRS',5)))
  type_vector = c(colnames(readcount))
  dds = load_data_for_DESeq2(file,condition_vector,type_vector)

  expect_equal(class(dds)[1],"DESeqDataSet")
  normalized_dds = normalize_dataset(dds)

  select_DEGs = select_DEG(dds = dds,filter_thresh = 0,log2_fc = log(1.5,2), padj=0.05)
  expect_equal(typeof(select_DEGs),"S4")
})

