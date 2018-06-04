##' This function parses wikipathways biopax file to a list format
##' for enrichment analysis.
##'
##' @title parse Wikipathways biopax file to a list format
##'
##' @param file *.biopax file
##' @return list
##' @export
##' @examples
##'
##' file <- system.file("extdata", "WP3620_95486.owl", package = "MSEAp")
##' wikip <- read.wikipathways(file)
##'
##' @author Kozo Nishida
## Simple function to read in a Wikipathways .biopax file and return a list of metabolite set
read.wikipathways <- function(file){
  if(!grepl("\\.owl$",file)[1])
    stop("Wikipathways Metabolite set information must be a .owl file")
  
  filename <- tail(unlist(strsplit(file, "/")), n=1)
  wikipathways.id <- unlist(strsplit(filename, "_"))[1]
  
  results <- paxtoolsr::readBiopax(file)
  wplist <- XML::xmlToList(results)
  
  pathway <- wplist[names(wplist) == "Pathway"]
  path.name <- pathway$Pathway$displayName$text
  
  #smols <- wplist[names(wplist) == "SmallMolecule"]
  smolrefs <- wplist[names(wplist) == "SmallMoleculeReference"]
  relxrefs <- wplist[names(wplist) == "RelationshipXref"]
  
  smolids <- unlist(purrr::map(smolrefs, "xref"))
  relxids <- unlist(purrr::map(relxrefs, ".attrs"))
  path.cpds <- unname(unlist(purrr::map(purrr::map(relxrefs[relxids %in% smolids], "id"), "text")))
  
  return(list(wikipathways.id, path.name, path.cpds))
}
