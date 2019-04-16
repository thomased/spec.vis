context("test-specvis")

test_that("data structure and integrity", {

  # Data
  data(specvis_spectra)
  data(specvis_meta)
  data(specvis_dict)

  # Structure
  expect_true(is.data.frame(specvis_meta))
  expect_true(is.data.frame(specvis_spectra))

  expect_equal(specvis_spectra[, 1], 300:700)

  # Completeness
  expect_equal(names(specvis_spectra[, -1]), specvis_meta$spec_name)
  expect_equal(specvis_dict$variable, names(specvis_meta))

  # Search
  expect_equivalent(specvis_search(genus == 'bombus')['spec_name'],
  data.frame(names(specvis_search(genus == 'bombus', return.spectra = TRUE)[,-1]), stringsAsFactors = FALSE))

})
