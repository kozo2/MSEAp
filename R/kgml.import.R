##' Extraction of compound set from KGML file (*.xml) to list
##'
##' Convertion of KEGG's XML (KGML) file (e.g. ath00630.xml) to compound set list
##'
##' The KGML files should be downloaded from KEGG FTP according to your own
##' licence.
##'
##' @param filename a file name of KEGG pathway in KGML format
##' @return list of KEGG compound IDs within a pathway
##' @author Atsushi Fukushima
##' @keywords list
##' @export
##' @examples
##'
##'     filename <- system.file("extdata/hsa04010.xml",
##'                             package="KEGGgraph") ## KGML downloaded from KEGG ftp
##'     kgml.import(filename)
##'
kgml.import <- function (filename) {
  ## pathway name
  path <- KEGGgraph::parseKGML(filename) ## load xml
  path.id <- KEGGgraph::getName(path)
  path.id <- gsub("path:", "", path.id)
  path.title <- KEGGgraph::getTitle(path)
  
  ## data
  nodes <- KEGGgraph::nodes(path)
  components <- unlist(lapply(nodes, KEGGgraph::getName))
  ## extraction of within-pathway compounds
  uniq.cmd <- NaN
  if(length(grep("^cpd|^gl|^dr", components))!=0) {
    uniq.cmd <- unique(components[grep("^cpd|^gl|^dr", components)])
    uniq.cmd <- gsub("^cpd:|^gl:|^dr:", "", uniq.cmd)
  }
  
  res <- list(c(path.id, path.title, list(uniq.cmd)))
  
  return(res)
}
