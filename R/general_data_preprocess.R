#' General Data preprocessing function
#'
#' @param df1 - dataframe with ship data
#'
#' @return data_list - list with multiple parameters
#' ranks, next latitude, next longitude
#' @export
#'
general_data_preprocess <- function(df1) {

  # create ranks object in ascending order
  ranks <- order(df1$DATETIME)

  # find the next latitude value based on ranks
  next_lat <- dplyr::lead(df1[ranks, "LAT"], n = 1L, default = NA)
  # find the next longitude value based on ranks
  next_lon <- dplyr::lead(df1[ranks, "LON"], n = 1L, default = NA)

  # create data list with ranks, next latitude value, next longitude value
  data_list <- list(ranks = ranks, next_lat = next_lat, next_lon = next_lon)

  return(data_list)

}
