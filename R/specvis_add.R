#' Add modelled sensitivity data
#'
#' Temporary helper function to add modelled sensitivity data to the database. Not for release.
#'
#' @author Thomas White \email{thomas.white026@@gmail.com}
#'
#' @importFrom utils write.csv
#'
#' @export
#'
#' @keywords internal
#'
specvis_add <- function(data, genus, species, citation_abbrev, doi, method, modelled = TRUE, sub = NA, sex = NA, note = NA) {

  new_meta <- data.frame(spec_name = names(data)[2:ncol(data)],
                    contributor = "thomas_white",
                    contributor_email = "thomas.white026@gmail.com",
                    citation_abbrev = citation_abbrev,
                    doi = doi,
                    method = method,
                    type = 'absorbance',
                    modelled = modelled,
                    genus = genus,
                    species = species,
                    sub = sub,
                    sex = sex,
                    note = note)


  specvis_meta <- read.csv("data-raw/specvis_meta.csv", stringsAsFactors = FALSE)
  specvis_meta <- rbind(specvis_meta, new_meta)

  specvis_spectra <- read.csv("data-raw/specvis_spectra.csv", stringsAsFactors = FALSE)
  specvis_spectra <- cbind(specvis_spectra, data[, -1])

  write.csv(specvis_meta, file = "data-raw/specvis_meta.csv", row.names = FALSE)
  write.csv(specvis_spectra, file = "data-raw/specvis_spectra.csv", row.names = FALSE)

}
