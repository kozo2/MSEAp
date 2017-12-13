##' This function generates metabolite set for metabolite
##' enrichment analysis using the KEGG REST API.
##'
##' @title Setup metabolite set by KEGG pathways
##'
##' @param organism 3-letters KEGG org code (e.g., eco, hsa, and ath)
##' @param listformat if true, return list object
##' @param target.path a character vector of KEGG pahtway IDs (default = NULL)
##' @param debug if true, debug mode run
##' @return list or data frame objects
##' @export
##' @examples
##' ## debug mode
##' res <- setup.KEGG.gmt(listformat = FALSE)
##' head(res)
##'
##' @author Atsushi Fukushima
setup.KEGG.gmt <- function(organism = "ath", listformat = TRUE, target.path = NULL,
                           debug = TRUE) {
  if (nchar(organism) != 3)
    stop("organism must specify 3-letters KEGG org code (e.g., hsa and ath)")
  if (is.null(target.path)) {
    target.path <- KEGGREST::keggLink(organism, "pathway")
    target.path <- gsub("^path:", "", names(target.path))
    target.path <- gsub(organism, "map", target.path)
    target.path <- unique(target.path)
  }
  if (!is.character(target.path))
    stop("target.path must be a character vector (e.g., \"map01060\", \"map01061\")")
  if (charmatch("", target.path) == 1)
    stop("target.path must contain >1 pathway")
  if (nchar(target.path[1]) != 8)
    stop("target.path must contain 8-letter KEGG pathway ID (e.g., map01060)")
  
  
  ## debug mode
  if (debug) {
    target.path <- target.path[1:2]
  }
  ##
  if (listformat)
    kegg.group <- list()
  else kegg.group <- data.frame()
  ##
  for (path.id in target.path) {
    cpds <- KEGGREST::keggLink("compound", path.id)
    cpds <- gsub("^cpd:", "", cpds)
    path.names <- KEGGREST::keggFind("pathway", path.id)
    names(path.names) <- NULL
    if (listformat) {
      kegg.group <- c(kegg.group, list(c(path.id, path.names, list(cpds))))
    } else {
      kegg.group <- rbind(kegg.group, data.frame(pathways = rep(path.id, length(cpds)),
                                                 cpds = cpds))
    }
  }
  return(kegg.group)
}