library('testthat')

source("/Users/jesizhao/Documents/gene_enrichment_visualization.R", chdir = TRUE)

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