
context("MSEAp plots")

test_that("MSEA columns for plot functions", {
  ## Does MSEA result has the vectors for the (dot)plot functions?
  res <- msea(mset_SMPDB_format_KEGG, kusano)
  expect_true("Expected" %in% names(res))
  expect_true("Metaboliteset.name" %in% names(res))
  expect_true("p.value" %in% names(res))
  expect_true("Hit" %in% names(res))

  ## skip_on_cran()    
  ## plot_msea <- function() plot(res)
  ## dotplot_msea <- function() dotplot(res)
  ## vdiffr::expect_doppelganger("msea plot", plot_msea)
  ## vdiffr::expect_doppelganger("msea dotplot", dotplot(res))

})
