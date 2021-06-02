#' This function runs the package as an example
#'
#' @export
#'

runShipExample <- function() {

  debuggingState(on=FALSE)
  appDir <- system.file("shiny-examples", "ships_app", package = "shipsdatapackage")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `shipsdatapackage`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
