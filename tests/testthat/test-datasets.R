context("Test for Datasets")

test_that("Datasets", {
  data(kusano)
  data(mset10hmdb)
  data(msea.example)
  data(fukushima17_INC)
  ## SMPDB
  data(mset_SMPDB_format_KEGG)
  data(mset_SMPDB_format_HMDB)
  data(mset_SMPDB_Metabolic_format_HMDB)
  ## AraCyc
  data(mset_AraCyc_format_KEGG)
  data(mset_AraCyc_format_HMDB)
  ## PlantCyc
  data(mset_PlantCyc_format_KEGG)
  data(mset_PlantCyc_format_HMDB)
  ## EcoCyc
  data(mset_EcoCyc_format_KEGG)
  data(mset_EcoCyc_format_HMDB)
  ## MetaCyc
  data(mset_MetaCyc_format_KEGG)
  data(mset_MetaCyc_format_HMDB)
  ## FlyCyc
  data(mset_FlyCyc_format_KEGG)
  ## MouseCyc
  data(mset_MouseCyc_format_KEGG)
  ## HumanCyc
  data(mset_HumanCyc_format_KEGG)
  ## AtMetExpress
  data(mset_AtMetExpress_Stress_format_KEGG)
  data(mset_AtMetExpress_Flavonoids_format_KNApSAcK)


  

  expect_identical(class(kusano), "character")

  #### SMPDB
  expect_identical(class(mset_SMPDB_format_KEGG), "list")
  expect_identical(class(mset_SMPDB_format_HMDB), "list")
  expect_identical(class(mset_SMPDB_Metabolic_format_HMDB), "list")
  
  #### AraCyc
  expect_identical(class(mset_AraCyc_format_KEGG), "list")
  expect_identical(class(mset_AraCyc_format_HMDB), "list")
  
  #### PlantCyc
  expect_identical(class(mset_PlantCyc_format_KEGG), "list")
  expect_identical(class(mset_PlantCyc_format_HMDB), "list")  
  
  #### EcoCyc
  expect_identical(class(mset_EcoCyc_format_KEGG), "list")
  expect_identical(class(mset_EcoCyc_format_HMDB), "list")
  
  #### MetaCyc
  expect_identical(class(mset_MetaCyc_format_KEGG), "list")
  expect_identical(class(mset_MetaCyc_format_HMDB), "list")
  
  #### FlyCyc
  expect_identical(class(mset_FlyCyc_format_KEGG), "list")

  #### MouseCyc
  expect_identical(class(mset_MouseCyc_format_KEGG), "list")

  #### HumanCyc
  expect_identical(class(mset_HumanCyc_format_KEGG), "list")
  
  #### AtMetExpress
  expect_identical(class(mset_AtMetExpress_Stress_format_KEGG), "list")
  expect_identical(class(mset_AtMetExpress_Flavonoids_format_KNApSAcK), "list")

  ####
  expect_identical(class(mset10hmdb), "list")
  expect_identical(class(msea.example), "character")

  #####################################################
  expect_equal(length(kusano), 13)
  expect_equal(length(mset10hmdb), 10)
  expect_equal(length(msea.example), 17)
  ## SMPDB
  expect_equal(length(mset_SMPDB_format_KEGG), 717)
  expect_equal(length(mset_SMPDB_format_HMDB), 717)
  expect_equal(length(mset_SMPDB_Metabolic_format_HMDB), 92)
  ## AraCyc
  expect_equal(length(mset_AraCyc_format_KEGG), 268)
  expect_equal(length(mset_AraCyc_format_HMDB), 350)
  ## PlantCyc
  expect_equal(length(mset_PlantCyc_format_KEGG), 606)
  expect_equal(length(mset_PlantCyc_format_HMDB), 714)
  ## EcoCyc
  expect_equal(length(mset_EcoCyc_format_KEGG), 222)
  expect_equal(length(mset_EcoCyc_format_HMDB), 254)
  ## MetaCyc
  expect_equal(length(mset_MetaCyc_format_KEGG), 1861)
  expect_equal(length(mset_MetaCyc_format_HMDB), 2059)
  ## FlyCyc
  expect_equal(length(mset_FlyCyc_format_KEGG), 90)
  ## MouseCyc
  expect_equal(length(mset_MouseCyc_format_KEGG), 71)
  ## HumanCyc
  expect_equal(length(mset_HumanCyc_format_KEGG), 89)
  ## AtMetExpress
  expect_equal(length(mset_AtMetExpress_Stress_format_KEGG), 9)
  expect_equal(length(mset_AtMetExpress_Flavonoids_format_KNApSAcK), 4)
})
