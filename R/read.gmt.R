##' This function parses gmt file to a list format
##' for enrichment analysis.
##'
##' @title parse gmt file to a list format
##'
##' @param file *.gmt file (a TAB-delimited file)
##' @param format select the compound DB-IDs ("KEGG", "HMDB", "KNApSacK")
##' @return list
##' @export
##' @examples
##'
##' file <- system.file("extdata", "sample_SMPDB.gmt", package = "MSEAp")
##' smp <- read.gmt(file)
##'
##' @author Atsushi Fukushima
## Simple function to read in a .gmt file and return a list of metabolite set
read.gmt <- function(file, format = "KEGG"){
  if(!grepl("\\.gmt$",file)[1])
    stop("Metabolite set information must be a .gmt file")

  ## read in the gmt file as a vector of lines
  metSetDB <- readLines(file, encoding = "UTF-8")
  metSetDB <- strsplit(metSetDB,"\t")
  res <- lapply(metSetDB, function(x) {
    smpdb.id <- unlist(x[1])
    path.name <- unlist(x[2])
    if (format == "general") {
      path.cpds <- unlist(x[3:length(x)])
    } else if (format == "KEGG") {
      path.cpds <- unlist(x[grep("^C\\d\\d\\d\\d\\d$", x)])
    } else if (format == "HMDB"){
      path.cpds <- unlist(x[grep("^HMDB\\d\\d\\d\\d\\d\\d\\d$", x)])
    } else if (format == "KNApSAcK"){
      path.cpds <- unlist(x[grep("^C\\d\\d\\d\\d\\d\\d\\d\\d$", x)])
    } else stop("Identifier format must be KEGG or HMDB or KNApSAcK.")

    if (length(path.cpds) > 0) {
      return(c(smpdb.id, path.name, list(path.cpds)))
    } else stop("Identifier format must be same.")
  })
  return(res)
}
