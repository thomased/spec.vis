context("test-specvis")

test_that("data structure and integrity", {

  # Data
  data(specvis_spectra)
  data(specvis_meta)

  # Structure
  expect_true(is.data.frame(specvis_meta))
  expect_true(is.data.frame(specvis_spectra))

  expect_equal(specvis_spectra[, 1], 300:700)

  # Completeness
  expect_equal(names(specvis_spectra[, -1]), specvis_meta$spec_name)
})
