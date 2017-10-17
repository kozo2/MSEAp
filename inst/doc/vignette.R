## ------------------------------------------------------------------------
library(MSEAp)
data(mset_SMPDB_format_KEGG)
data(kusano)
res <- msea(mset_SMPDB_format_KEGG, kusano)
plot(res)
##
head(kusano)
mset_SMPDB_format_KEGG[[1]]

## ------------------------------------------------------------------------
file <- system.file("extdata", "sample_SMPDB.gmt", package = "MSEAp")
smp <- read.gmt(file)

## ------------------------------------------------------------------------
## file <- system.file("extdata/map00260.xml", package="KEGGgraph")## KGML downloaded from KEGG ftp
## kgml.import(file)

## ------------------------------------------------------------------------
res <- setup.KEGG.gmt(listformat = TRUE)
res[[1]]

## ------------------------------------------------------------------------
## filepath <- "./hsa.tar.gz" ## *.tar.gz downloaded from KEGG
## res <- setupPathwayClass(filepath) ## convert to list

## ------------------------------------------------------------------------
help(package = "MSEAp")

## ------------------------------------------------------------------------
data(mset_AraCyc_format_KEGG)
data(mset_AtMetExpress_Stress_format_KEGG)
data(mset_AtMetExpress_Flavonoids_format_KNApSAcK)
mset <- c(
  mset_AraCyc_format_KEGG,
  mset_AtMetExpress_Stress_format_KEGG,
  mset_AtMetExpress_Flavonoids_format_KNApSAcK
  )
length(mset) ## 281 metabolite-sets
data(fukushima17_INC)
head(fukushima17_INC)
res <- msea(mset, fukushima17_INC$kegg_knap)
head(res)
plot(res, show.limit = 10)

## ------------------------------------------------------------------------
data(mset_SMPDB_Metabolic_format_HMDB)
data(msea.example)
res <- msea(mset_SMPDB_Metabolic_format_HMDB, msea.example)

dotplot(res)  ## You may have to zoom this plot in RStudio and other R working environments
barplot(res)  ## You can see the same plot by plot()

## ----sessionInfo, echo=FALSE---------------------------------------------
sessionInfo()

