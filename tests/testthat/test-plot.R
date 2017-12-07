
context("MSEAp plots")

test_that("plot msea", {
  skip_on_cran()
  res <- msea(mset_SMPDB_format_KEGG, kusano)
  plot_msea <- function() plot(res)
  dotplot_msea <- function() dotplot(res)
  vdiffr::expect_doppelganger("msea plot", plot_msea)
  vdiffr::expect_doppelganger("msea dotplot", dotplot(res))
})
