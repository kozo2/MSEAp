##' This function performs Metabolite Set
##' Enrichment Analysis (MSEA) with KEGG COMPOUND IDs.
##'
##' @title identifies biologically meaningful accumulations in metabolomic data
##'
##' @param metabolite.set a list of metabolite sets
##' @param mets.queryset a list of metabolites for which enrichment test is to be done
##' @return msea object
##' @export
##' @examples
##' data(mset_SMPDB_format_KEGG)
##' data(kusano)
##'
##' res <- msea(mset_SMPDB_format_KEGG, kusano)
##'
##' @author Atsushi Fukushima
##'
## metaboliteset enrichment analysis
## based on fisher's exact test
msea <- function(metabolite.set, mets.queryset){
  mets.refset <- extract.uniq.metabolites(metabolite.set)
  res.fisher.test <- lapply(metabolite.set, calc.fisher.test, mets.queryset, mets.refset)
  res <- formatting.results(res.fisher.test)
  class(res) <- c("msea", "data.frame")
  return(res)
}

## This function extracts unique metabolites in Metabolite set
extract.uniq.metabolites <- function(metabolite.set) {
  res <- unique(unlist(lapply(metabolite.set, function(x) unlist(x[3]))))
  return(res)
}

## This function performs Fisher's exact test.
calc.fisher.test <- function(list, mets.queryset, mets.refset) {
  res <- list()
  res$ID <- unlist(list[1])
  res$setname <- unlist(list[2])
  metabolite.set <- unlist(list[3])
  mets.interest <- intersect(mets.queryset, metabolite.set)

  yy <- length(intersect(metabolite.set, mets.queryset))
  yn <- length(setdiff(metabolite.set, mets.queryset))
  ny <- length(mets.queryset) - yy
  nn <- length(mets.refset) + yy - length(mets.queryset) - length(metabolite.set)

  test.res <- stats::fisher.test(rbind(c(yy, yn), c(ny, nn)), alternative = "greater")
  res$pvalue <- test.res$p.value

  res$total <- length(metabolite.set)
  res$hit <- yy

  expected <- length(mets.queryset) * ( length(metabolite.set) / length(mets.refset) )
  res$expected <- round(expected, digits = 2)

  res$overlap.percent <- round(length(mets.interest)/length(metabolite.set) * 100, digits = 2)
  res$overlap.metabolites <- paste(mets.interest, collapse=", ")

  ## Correcting multiple testing problem by BH method
  res$pvalue <- format(res$pvalue, scientific = TRUE, digits = 4)

  return(res)
}


## This function formats the results of MSEA.
formatting.results <- function(list) {
  res <- data.frame()
  pathway.ID <- sapply(list, function(x) unlist(x$ID))
  Metaboliteset.name <- sapply(list, function(x) unlist(x$setname))
  Total <- sapply(list, function(x) unlist(x$total))
  Expected <- sapply(list, function(x) unlist(x$expected))
  Hit <- sapply(list, function(x) unlist(x$hit))  
  p.value <- sapply(list, function(x) unlist(x$pvalue))
  Holm.p <- stats::p.adjust(sapply(list, function(x) unlist(x$pvalue)), method = "holm")
  FDR <- stats::p.adjust(sapply(list, function(x) unlist(x$pvalue)), method = "fdr")
  Overlap.percent <- sapply(list, function(x) unlist(x$overlap.percent))
  Overlap.metabolites <- sapply(list, function(x) unlist(x$overlap.metabolites))
  ##  URL <- paste("http://www.genome.jp/dbget-bin/www_bget?", KEGG.pathway.ID, sep = "")
  res <- data.frame(cbind(pathway.ID, Metaboliteset.name, 
                          Total, Expected, Hit,
                          p.value, Holm.p, FDR, 
                          Overlap.percent, Overlap.metabolites))
  ordered.res <- res[order(as.numeric(as.character(res$p.value))),] 
  return(ordered.res)
}
