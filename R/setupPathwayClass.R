#' Convert metabolite set (multiple) / tar.gz to list
#'
#' Convertion of KEGG's tar.gz files (e.g. hsa.tar.gz) to metabolite set list
#'
#' The tar.gz files should be downloaded from KEGG FTP according to your own
#' licence.
#'
#' @param filepath file path of KEGG's tar.gz files
#' @return list of KEGG compound IDs within a pathway
#' @author Atsushi Fukushima
#' @keywords list
#' @examples
#'
#' 	## filepath <- "./hsa.tar.gz" ## *.tar.gz downloaded from KEGG
#' 	## res <- setupPathwayClass(filepath) ## convert to list
#'
setupPathwayClass <- function (filepath) {

  if (file.exists(filepath) == FALSE) {
    stop("Error: *tar.gz File not exist there.")
  }

  prev.dir <- getwd()

  ##  untar(filepath)
  setwd(dirname(filepath))

  ## split of filepath
  words <- strsplit(filepath,"/")
  target <- words[[1]][length(words[[1]])]
  utils::untar(target)
  filename <- target[length(target)]

  # set current directory
  target.dir <- strsplit(filename, "\\.")[[1]][1]
  # file list
  files <- list.files(target.dir, pattern="*.xml$|*.XML")

  if (length(files)==0) {
    stop("Error: No XML file exists. Please check the *tar.gz file (it should be downloaded from ftp://ftp.bioinformatics.jp/kegg/xml/kgml/).")
  }

  # get current directory
  cur.dir <- getwd()
  setwd(target.dir)

  res <- NaN
  Name <- NaN

  k <- 1
  for (xmlfile in files) {
    if (grep("xml", xmlfile)==1){
      path.cmd <- kgml.import(xmlfile)
      res[k] <- path.cmd ## compound IDs
      Name[k] <- names(path.cmd)
      k <- k+1
      }
  }

  names(res) <- Name
  setwd(prev.dir)
  return(res)
}
