## util.R

##' Display supported metabolite-sets for metabolite set enrichment analysis (MSEA).
##' @return metabolite-set name available in MSEAp package. 
##' @examples
##' supported.msets()
##' @export
supported.msets <- function() {
    piqr <- utils::data(package = "MSEApdata")

    data.files <- piqr$results[, 3]
    mset.files <- grep("^mset_", data.files, value = TRUE)
    return(mset.files)
}
