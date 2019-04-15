#' Search the spectra.visual database
#'
#' Search the spectra.visual database.
#'
#' @importFrom utils data
#' @importFrom dplyr filter
#'
#' @param ... One or more search conditions to match (note: must use relational operators, e.g.
#'  \code{==}, \code{<=}). Can match against any variables listed in the dictionary in
#'  \code{\link{specvis_dict}}, namely:
#'  \itemize{
#'   \item \code{spec_name}:
#'   \item \code{contributor}:
#'   \item \code{contributor_email}:
#'   \item \code{citation_abbrev}:
#'   \item \code{doi}:
#'   \item \code{method}:
#'   \item \code{type}:
#'   \item \code{modelled}:
#'   \item \code{genus}:
#'   \item \code{species}:
#'   \item \code{sub}:
#'   \item \code{sex}:
#'  }
#' @param return.spectra A logical argument specifying whether the raw spectra be returned.
#' Defaults to \code{FALSE}, thereby returning all metadata associated with a query.
#'
#' @return A data frame of reflectance spectra from binned in 1 nm intervals
#'  from 300-700 nm, with the first column containing wavelengths ('wl').
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' # Query the database to see how many spectra from the genus 'bombus'
#' # are available, and examine their metadata
#' specvis_search(genus == "bombus")
#'
#' # Save the corresponding spectra to an object
#' bombus_vis <- specvis_search(genus == "bombus", return.spectra = TRUE)
#' }
#'
#' @author Thomas White \email{thomas.white026@@gmail.com}
#'
specvis_search <- function(..., return.spectra = FALSE, plot = FALSE) {

  # This is a proof-of-concept. Probably a way to do the equivalent without dplyr, which would be ideal.

  spectra <- get(data(specvis_spectra, envir = environment()))
  meta <- get(data(specvis_meta, envir = environment()))

  # Get selected id's
  id <- dplyr::filter(meta, ...)

  message(paste0("Found ", nrow(id), " spectra from ", length(unique(id$species)), " species."))

  if (!return.spectra) {
    id
  } else {
    # Get spectra
    specs <- subset(spectra, select = id$spec_name)

    # Add wavelength column
    specs <- cbind(spectra$wl, specs)
    names(specs)[1] <- "wl"

    specs
  }
}
