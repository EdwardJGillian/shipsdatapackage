#' General Data preprocessing function
#'
#' @param df1 - dataframe with ship data
#'
#' @return data_list - list with multiple parameters
#' ranks, next latitude, next longitude
#' @export
#'
general_data_preprocess <- function(df1) {

  ranks <- order(df1$DATETIME)

  next_lat <- dplyr::lead(df1[ranks, "LAT"], n = 1L, default = NA)
  next_lon <- dplyr::lead(df1[ranks, "LON"], n = 1L, default = NA)


  data_list <- list(ranks = ranks, next_lat = next_lat, next_lon = next_lon)
  #names(data_list) <- c("ranks", "next_lat","next_lon")
  return(data_list)

}
