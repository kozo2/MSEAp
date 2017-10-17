context("msea: an R package for metabolite set enrichment analysis (MSEA)")


test_that("MSEA calculation", {
  data(msea.example) ## 17 metabolites
  data(mset10hmdb)   ## 10 metabolite-sets

  ## MSEA calculation by DEMO datasets
  mset <- mset10hmdb[[4]][[3]]  ## "GLYCINE, SERINE AND THREONINE METABOLISM"
  mets.refset <- extract.uniq.metabolites(mset10hmdb)
  yy <- length(intersect(mset, msea.example))
  yn <- length(setdiff(mset, msea.example))
  ny <- length(msea.example)-yy
  nn <- length(mets.refset)+yy-length(msea.example)-length(mset)

  p.val <- fisher.test(rbind(c(yy,yn),c(ny,nn)), alternative = "greater")$p.value

  ## using metaboliteset.enrichment() function
  res <- msea(mset10hmdb, msea.example)
  
  ## expected values
  expect_equal(mset[1], "HMDB00005")
  expect_equal(mset[26], "HMDB06454")
  expect_equal(length(mset), 26)
  expect_equal(length(mets.refset), 174)
  expect_equal(yy, 9)
  expect_equal(yn, 17)
  expect_equal(ny, 8)
  expect_equal(nn, 140)
  expect_equal(p.val, 0.0001054608)
  ## res
  p.val <- round(p.val, digits = 7)
  p.val2 <- as.numeric(as.character(res$p.value[1]))
  expect_true(p.val == p.val2)
  
})
