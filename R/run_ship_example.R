#' This function runs the package as an example
#'
#' @export
#'

run_ship_example <- function() {

  appDir <- system.file("shiny-examples", "ships_app", package = "shipsdatapackage")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `shipsdatapackage`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")

  debuggingState(on = FALSE)
  # installing new version of later did not resolve the following issue:
  # https://github.com/rstudio/shiny/issues/2081

}

