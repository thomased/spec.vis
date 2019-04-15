#' Rebuild the database
#'
#' Helper function to rebuild the database by saving raw data as compiled rda objects
#'
#' @author Thomas White \email{thomas.white026@@gmail.com}
#'
#' @importFrom utils read.csv
#'
#' @export
#'
#' @keywords internal
#'
specvis_rebuild <- function() {

  specvis_meta <- read.csv("data-raw/specvis_meta.csv", stringsAsFactors = FALSE, check.names = FALSE)
  specvis_spectra <- read.csv("data-raw/specvis_spectra.csv", stringsAsFactors = FALSE, check.names = FALSE)
  specvis_dict <- read.csv("data-raw/specvis_dict.csv", stringsAsFactors = FALSE, check.names = FALSE)

  save(specvis_meta, file = "data/specvis_meta.rda", compress = 'xz')
  save(specvis_spectra, file = "data/specvis_spectra.rda", compress = 'xz')
  save(specvis_dict, file = "data/specvis_dict.rda", compress = 'xz')

  print(paste0("Databse contains ", ncol(specvis_spectra), " spectra from ", length(unique(sub("(^[^.]+[.][^.]+)(.+$)", "\\1", specvis_meta$spec_name))), " species"))
}
