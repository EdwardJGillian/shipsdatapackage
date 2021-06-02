#' Calculate the shortest distance between two points on an ellipsoid
#'
#' @param x_lon - x longitude
#' @param x_lat - x latitude
#' @param y_lon - y longitude
#' @param y_lat - y latitude
#'
#' @return distance between 2 points
#' @export
#'
calculate_distance <- function(x_lon, x_lat, y_lon, y_lat) {
  geosphere::distGeo(c(x_lon, x_lat), c(y_lon, y_lat))
}
