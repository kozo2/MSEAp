
context("MSEAp plots")

test_that("MSEA columns for plot functions", {
  ## Does MSEA result has the vectors for the (dot)plot functions?
  res <- msea(mset_SMPDB_format_KEGG, kusano)
  expect_true("Expected" %in% names(res))
  expect_true("Metaboliteset.name" %in% names(res))
  expect_true("p.value" %in% names(res))
  expect_true("Hit" %in% names(res))
  
  foo <- netplot(res, mset_SMPDB_format_KEGG, shared.metabolite = 20)
  bar <- foo$x$edges
  expect_equal(as.character(bar$from[1]), "SMP00007")
  expect_equal(as.character(bar$to[1]), "SMP00351")
  expect_equal(as.character(bar$shared[1]), "C00001 C00003 C00004 C00005 C00006 C00007 C00010 C00011 C00014 C00016 C00018 C00024 C00025 C00026 C00027 C00038 C00049 C00061 C00070 C00076 C00080 C00099 C00106 C00135 C00222 C00386 C00429 C00864 C00986 C01152 C01262 C02642 C05665")

  ## skip_on_cran()    
  ## plot_msea <- function() plot(res)
  ## dotplot_msea <- function() dotplot(res)
  ## vdiffr::expect_doppelganger("msea plot", plot_msea)
  ## vdiffr::expect_doppelganger("msea dotplot", dotplot(res))

})
