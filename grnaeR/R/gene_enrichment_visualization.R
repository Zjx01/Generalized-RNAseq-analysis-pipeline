library(magrittr)
library(dplyr)
library(tidyverse)
require(enrichplot)
library(ggpubr)
library(MASS)
library("ggplot2")

#' filter_genelist
#'
#' This function select interested genes with abolute value greater than assigned threshold and convert to large enrichResult. l
#' @param geneList should be a list of gene foldchange level or with names of geneID
#' @param standard_fc the foldchange threshold for filtering
#' @return edo object
#' @importFrom DOSE enrichDGN
#' @export
filter_genelist <- function(geneList, standard_fc) {
  if (length(geneList) == 0) {
    print("the gene List is empty, please put in the correct geneList")
  } else {
    de <- names(geneList)[abs(geneList) > standard_fc]
    # edo is large enrichResult
    print("enrichResult object generated")
    edo <- enrichDGN(de)
  }
}


#' Bar plot
#'
#' Bar plot is the most widely used method to visualize enriched terms. It depicts the enrichment scores (e.g. p values) and gene count or ratio as bar height and color
#' @param edo large enrichResult
#' @param showCategory_num specify the number of terms (most significant) or selected terms to display
#' @importFrom graphics barplot
#' @export
show_barplot <- function(edo, showCategory_num) {
  bar_plot <- barplot(edo, showCategory = showCategory_num)
}


# show_barplot(edo,showCategory_num = 20)



#' Dotplot
#'
#' method to visualize enriched terms via dot plot
#' @param edo large enrichResult
#' @param showCategory_num specify the number of terms (most significant) or selected terms to display
#' @importFrom DOSE gseDO
#' @importFrom enrichplot dotplot
#' @importFrom ggpubr ggarrange
#' @importFrom ggplot2 ggtitle
#' @export
#'
show_dotplot <- function(edo, showCategory_num) {
  edo2 <- gseDO(geneList) # edo2 is large gseaResult
  # over representation analysis
  ORA_dotplot <- dotplot(edo, showCategory = showCategory_num) + ggtitle("dotplot for ORA")
  # gene set enrichment analysis
  GSEA_dotplot <- dotplot(edo2, showCategory = showCategory_num) + ggtitle("dotplot for GSEA")
  ggarrange(ORA_dotplot, GSEA_dotplot, nrow = 1, ncol = 2)
}

# show_dotplot(edo,showCategory_num=30)


#' Gene-Concept Network Plot
#'
#' visualize the potentially biological complexities in which a gene may belong to multiple annotation categories and provide information of numeric changes if available
#' convert gene ID to Symbol,to notice the default OrgDb and keytype we use is 'org.Hs.eg.db'(human) and
# Entrez Gene ID and, it should be change when the input geneID changes
#' @param edo edoobject
#' @param  geneList genelist object
#' @param category_size category_size
#' @param keyType the key you have
#' @param OrgDb defaulted
#' @importFrom DOSE setReadable
#' @importFrom enrichplot cnetplot
#' @export

develop_Gene_Network <- function(edo, geneList, OrgDb = "org.Hs.eg.db", keyType = "ENTREZID", category_size = "pvalue") {
  # map geneID to gene Symbol
  options(ggrepel.max.overlaps = Inf)
  edox <- setReadable(edo, OrgDb, keyType)
  ## categorySize can be scaled by 'pvalue' or 'geneNum'
  p1 <- cnetplot(edox, categorySize = category_size, color.params = list(foldChange = geneList), max.overlaps = Inf)
}


#' Function to plot edo output as a network
#
#' @param edo large enrichResult
#' @param cex_category The cex_category parameter can be used to resize nodes
#' @importFrom enrichplot pairwise_termsim
#' @importFrom enrichplot emapplot
#' @export

enrichmap <- function(edo, cex_category = 1.1) {
  # Ignore/omit warnings that objects will overlap and maximize size to avoid overlap
  options(ggrepel.max.overlaps = Inf)
  # Define enrichment result object
  edo <- pairwise_termsim(edo)
  # Default emap plot 1
  p1 <- emapplot(edo)
  # Change node size using cex.params
  p2 <- emapplot(edo, cex.params = list(category_node = cex_category))
  # Return a list as cowplot to combine figures
  cowplot::plot_grid(p1, p2, ncol = 2, labels = LETTERS[1:2])
}
