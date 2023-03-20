#how to make a workflow
library('dplyr')
library('ggplot2')
library("pheatmap")
library("RColorBrewer")
library('DESeq2')
library('AnnotationDbi')
library('org.Hs.eg.db')

#' Load the data
#' @param dir The working directory
#' @param file The path of rnaseq raw count
#' @export
load_data<-function(dir,file){
  setwd(dir)
  readcount = read.delim(file,sep = '',row.names = 1)
  return(readcount)
}

#' @export
check_exonlength <- function(readcount){
  if('exonlength' %in% colnames(readcount)){
    exon_Exist = TRUE
  }else{
    exon_Exist = FALSE
  }
  return(exon_Exist)
}

#' data quality control: check the total coverage
#' @export
check_totalcov_quality<-function(readcount){
  if(check_exonlength(readcount)){
    readcount = readcount[,-dim(readcount)[2]]
  }
  total.cov = apply(readcount,2,sum)
  barplot(total.cov,las=2,ylab="log10(total counts over genes)")
  return(total.cov)
}

#' data quality control: check the number of genes being covered
#' @export
check_genecovered_quality<-function(readcount){
  if(check_exonlength(readcount)){
    readcount = readcount[,-dim(readcount)[2]]
  }
  genecovered = apply(readcount,2,function(x) sum(x>0))
  barplot(genecovered,las=2,ylab ="gene covered")
  return(genecovered)
}

#' @export
calculate_RPKM = function(readcount){
  if(check_exonlength(readcount)){
    rpk = readcount/readcount$exonlength*10^3
    rpkm = rpk[,-dim(readcount)[2]+1]
    total.cov = check_totalcov_quality(readcount)
    #calculate RPKM
    for (i in 1:dim(readcount)[2]){
      rpkm[,i]=rpk[,i]/total.cov[i]*10^6
    }
  }else{
   return(
     "the exonlength should be contained in provided file to calculate RPKM"
   )
  }
}


#' @export
load_data_for_DESeq2 <- function(file,condition_vector,type_vector){

  readcount = read.table(file,header = T,row.names = 1)
  configure = data.frame(condition = factor(condition_vector),type = type_vector)

  if(check_exonlength(readcount) == TRUE){
    readcount = readcount[,-dim(readcount)[2]]
  }

  dds <- DESeqDataSetFromMatrix(countData = readcount,
                                colData = configure,
                                design = ~ condition)
}
  dds = estimateSizeFactors(dds)
  return(dds)
}

#' @export
normalize_dataset <- function(dds){
  #we provide vst and rlog normalization and choose the methods based on sample sizes
  if(dim(dds)[2]<=30){
    normalized = rlog(dds,blind = FALSE)
  }else{
    normalized = vst(dds,blind = FALSE)
  }
  return(normalized)
}

#' Generalized sample distance
#' @export
check_sample_distance<-function(normalized_dds){
  sampleDists = dist(t(assay(normalized_dds)))
  sampleDistMatrix = as.matrix(sampleDists)
  rownames(sampleDistMatrix) = paste(normalized_dds$type,normalized_dds$condition,sep = '-')
  colors = colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
  pheatmap(sampleDistMatrix,
           clustering_distance_rows = sampleDists,
           clustering_distance_cols = sampleDists,
           col = colors)
  #plot PCA as well
  plotPCA(normalized_dds)
}


#' differential gene expression and return their Entriz ID/SYMBOL for further gene enrichment analysis
#' @export
select_DEG<- function(dds,filter_thresh = 0,log2_fc = 2, padj=0.05){
  pre_count_num = dim(counts(dds))
  keep = rowSums(counts(dds)) > filter_thresh
  dds = dds[keep,]
  after_count_num = dim(counts(dds))
  filtered_num = pre_count_num[1] - after_count_num[1]
  print(paste("filtering",filtered_num,"genes with low counts"),sep = ' ')

  dds = DESeq(dds)
  res = results(dds)

  res05 = results(dds,alpha = padj , lfcThreshold = log2_fc)
  summary(res05)

  selected_res<-subset(res05,padj<=padj,abs(log2FoldChange)>=log2_fc)

  selected_res$entrez <- mapIds(org.Hs.eg.db,
                                keys = row.names(selected_res),
                                column = "ENTREZID",
                                keytype = "ENSEMBL",
                                multiVals = "first")

  selected_res$entrez <- mapIds(org.Hs.eg.db,
                                keys = row.names(selected_res),
                                column = "SYMBOL",
                                keytype = "ENSEMBL",
                                multiVals = "first")
}

#test case
# dir = '/Users/jesi/Documents'
# file = '/Users/jesi/Documents/CRS_34v0.txt'
# readcount = load_data(dir,file)
# check_totalcov_quality(readcount)
# check_genecovered_quality(readcount)
# calculate_RPKM(readcount)
# condition_vector = c(c(rep('CRS',4)),c(rep('noCRS',5)))
# type_vector = c(colnames(readcount))
# dds = load_data_for_DESeq2(file,condition_vector,type_vector)
# normalized_dds = normalize_dataset(dds)
# check_sample_distance(normalized_dds)
# select_DEGs = select_DEG(dds = dds,filter_thresh = 0,log2_fc = log(1.5,2), padj=0.05)
