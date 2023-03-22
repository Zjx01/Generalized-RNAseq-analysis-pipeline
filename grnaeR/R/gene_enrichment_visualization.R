library(magrittr)
library(dplyr)
library(tidyverse)
library(enrichplot)
library(ggpubr)
library(MASS)
library('ggplot2')

#' filter_genelist
#'
#' @param genelist should be a list of gene foldchange level or with names of geneID
#' @return edo object
#' This function select interested genes with abolute value greater than assigned threshold and convert to large enrichResult
#' @export
filter_genelist<-function(geneList,standard_fc){
  if(length(geneList)==0){
    print("the gene List is empty, please put in the correct geneList")
  }else{
    de <- names(geneList)[abs(geneList) > standard_fc]
    #edo is large enrichResult
    print("enrichResult object generated")
    edo <- enrichDGN(de)
  }
}



#' Bar plot
#'
#' generate the barplot of gene bar plot
#' @export
show_barplot<-function(edo,showCategory_num,barp_name){
  combined_plot = barplot(edo, showCategory=showCategory_num)
  p = combined_plot + png(barp_name)
  print("bar plot generated")
}


#show_barplot(edo,showCategory_num = 20,"barplot")



#' Dotplot
#'
#' generate the dotplot for gene interactome
#' @export
show_dotplot<-function(edo,showCategory_num,dotpf_name){
  edo2 <- gseDO(geneList) #edo2 is large gseaResult
  ORA_dotplot <- dotplot(edo, showCategory = showCategory_num) + ggtitle("dotplot for ORA")
  GSEA_dotplot <- dotplot(edo2, showCategory = showCategory_num) + ggtitle("dotplot for GSEA")
  combined_plot <- ggarrange(ORA_dotplot,GSEA_dotplot,nrow = 1,ncol = 2)

  #save the generated dotplots in pnf format
  p = combined_plot + png(dotpf_name)
  print('successfully generated dotplot')
}

#show_dotplot(edo,showCategory_num=30,dotpf_name = 'combined_dotplot.png')


#' Gene-Concept Network Plot
#' convert gene ID to Symbol,to notice the default OrgDb and keytype we use is 'org.Hs.eg.db'(human) and
#Entrez Gene ID and, it should be change when the input geneID changes
#' @export
#' @param edo edoobject
#' @param  geneList genelist object
#' @param GeneNetp_name image_name
#' @param category_size,keyType,OrgDb defaulted
develop_Gene_Network <- function(edo,geneList,GeneNetp_name,OrgDb = 'org.Hs.eg.db',keyType = 'ENTREZID',category_size = 'pvalue'){
  edox <- setReadable(edo, OrgDb, keyType)
  p1 <- cnetplot(edox, foldChange=geneList,max.overlaps = Inf)
  ## categorySize can be scaled by 'pvalue' or 'geneNum'
  p2 <- cnetplot(edox, categorySize= category_size, foldChange=geneList, max.overlaps = Inf)
  p3 <- cnetplot(edox, foldChange=geneList, circular = TRUE, colorEdge = TRUE, max.overlaps = Inf)
  p = cowplot::plot_grid(p1, p2, p3, ncol=3, labels=LETTERS[1:3], rel_widths=c(.8, .8, 1.2), max.overlaps = Inf) + png(GeneNetp_name)
  print("successfully generated gene Network")
}





