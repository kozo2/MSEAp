##' A metabolite list. We analyzed the Arabidopsis metabolome of the aerial
##' regions of individual WT plants under UV-B treatment
##' by GC-TOF/MS.
##'
##' This list is corresponding to significantly accumulated metabolites
##' between UV-B (1 day treatment) and control conditions.
##'
##' @name kusano
##' @docType data
##' @title list of significant metabolites based on Kusano et al. Plant J (2011)
##'
##' @keywords datasets
##' @references Miyako Kusano et al. Plant J 67:354-369 (2011)
##' @author Atsushi Fukushima
NULL

##' A metabolite list. Using GC-TOF/MS and LC-q-TOF/MS, We analyzed the
##' Arabidopsis metabolome of the aerial parts of individual WT plants
##' under mild oxidative stress elicited by methyl viologen.
##'
##' This list is corresponding to significantly accumulated metabolites
##' between mild oxidative stress and control conditions.
##' This study identified 37 significant increased metabolites
##' (log2foldchange >= 1 and FDR < 0.05) including
##' primary- and secondary metabolites, mainly flavonols and anthocyanins.
##'
##' @name fukushima17_INC
##' @docType data
##' @title list of signicant metabolite set based on Fukushima et al. (2017).
##'
##' @keywords datasets
##' @references Atsushi Fukushima, Mami Iwasa et al. Front Plant Sci 8:1464 (2017) doi: 10.3389/fpls.2017.01464
##' @author Atsushi Fukushima
NULL



##' An example INPUT metabolite-set related to MSEA analysis in MetaboAnalyst.
##'
##'
##' @name msea.example
##' @docType data
##' @title An example INPUT list based on HMDB-IDs
##'
##' @keywords datasets
##' @references Xia et al. Nucleic Acids Res. 43:W251-W257 (2015).
##' @author Atsushi Fukushima
NULL

##' A selected metabolite-set in MetaboAnalyst.
##'
##' It includes 10 metabolite-sets selected from the pre-defined metabolite
##' sets in MetaboAnalyst (filename: metaboliteset_example.csv).
##'
##' @name mset10hmdb
##' @docType data
##' @title An example UNIVERSE list based on HMDB-IDs
##'
##' @keywords datasets
##' @references Xia et al. Nucleic Acids Res. 43:W251-W257 (2015).
##' @author Atsushi Fukushima
NULL

##' A metabolite set based on SMPDB (http://smpdb.ca/).
##' We downloaded the CSV file of metabolite names that
##' linked to SMPDB pathways (ver. 2). SMPDB pathway IDs and
##' HMDB IDs were extracted.
##'
##'
##' @name mset_SMPDB_format_HMDB
##' @docType data
##' @title A metabolite set (HMDB-IDs) based on SMPDB
##'
##' @keywords datasets
##' @references Jewison T, et al. Nucleic Acids Res. 42:D478-484 (2014).
##' @author Atsushi Fukushima
NULL

##' A metabolite set based on SMPDB (http://smpdb.ca/).
##' We downloaded the CSV file of metabolite names that
##' linked to SMPDB pathways (ver. 2). SMPDB pathway IDs and
##' HMDB IDs were extracted. This dataset includes 92 core metabolic pathways.
##'
##'
##' @name mset_SMPDB_Metabolic_format_HMDB
##' @docType data
##' @title A metabolite set (HMDB-IDs) based on SMPDB core metabolic pathways
##'
##' @keywords datasets
##' @references Jewison T, et al. Nucleic Acids Res. 42:D478-484 (2014).
##' @author Atsushi Fukushima
NULL

##' A metabolite set based on SMPDB (http://smpdb.ca/).
##' We downloaded the CSV file of metabolite names that
##' linked to SMPDB pathways (ver. 2). SMPDB pathway IDs and
##' KEGG COMPOUND IDs were extracted.
##'
##'
##' @name mset_SMPDB_format_KEGG
##' @docType data
##' @title A metabolite set (KEGG COMPOUND-IDs) based on SMPDB
##'
##' @keywords datasets
##' @references Jewison T, et al. Nucleic Acids Res. 42:D478-484 (2014).
##' @author Atsushi Fukushima
NULL

##' A metabolite set based on AraCyc
##' (http://www.plantcyc.org/databases/aracyc/15.0).
##' We extracted the pathway information from the biopax-level2.owl
##' AraCyc pathway IDs and KEGG COMPOUND IDs were extracted. This dataset
##' contains 268 metabolite sets linked to KEGG COMPOUND IDs. There are only
##' metabolite sets containing at least 5 compounds.
##'
##' @name mset_AraCyc_format_KEGG
##' @docType data
##' @title A metabolite set (KEGG COMPOUND-IDs) based on AraCyc
##'
##' @keywords datasets
##' @references Zhang P, et al. Plant Physiol. 138:27-37 (2005).
##' @author Atsushi Fukushima
NULL

##' A metabolite set based on AraCyc
##' (http://www.plantcyc.org/databases/aracyc/15.0).
##' We extracted the pathway information from the biopax-level2.owl
##' AraCyc pathway IDs and HMDB IDs were extracted. This dataset
##' contains 350 metabolite sets linked to HMDB IDs. There are only
##' metabolite sets containing at least 5 compounds.
##'
##'
##' @name mset_AraCyc_format_HMDB
##' @docType data
##' @title A metabolite set (HMDB-IDs) based on AraCyc
##'
##' @keywords datasets
##' @references Zhang P, et al. Plant Physiol. 138:27-37 (2005).
##' @author Atsushi Fukushima
NULL

##' A metabolite set based on AtMetExpress, has been curated manually.
##' We extracted the metabolite set information from publicly available
##' metabolite datasets in response to various stress treatment.
##' KEGG IDs were assigned to the sets. This dataset contains
##' 9 metabolite sets linked to KEGG COMPOUND IDs. There are only
##' metabolite sets containing at least 5 compounds.
##'
##'
##' @name mset_AtMetExpress_Stress_format_KEGG
##' @docType data
##' @title A metabolite set (KEGG COMPOUND-IDs) based on AtMet
##'
##' @keywords datasets
##' @references Obata and Fernie, Cell Mol Life Sci 69:3225-3243 (2012).
##' @author Atsushi Fukushima
NULL

##' A metabolite set based on AtMetExpress, has been curated manually.
##' We extracted the metabolite set information from publicly available
##' metabolite datasets involved in flavonoid pathways in Arabidopsis.
##' KNApSAcK IDs were assigned to the sets. This dataset contains
##' 4 metabolite sets linked to KNApSAcK IDs. There are only
##' metabolite sets containing at least 5 compounds.
##'
##'
##' @name mset_AtMetExpress_Flavonoids_format_KNApSAcK
##' @docType data
##' @title A metabolite set (KNApSAcK-IDs) based on AtMet
##'
##' @keywords datasets
##' @references Saito et al. Plant Physiol Biochem. 72:21-34 (2013).
##' @author Atsushi Fukushima
NULL