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

  nextLat <- dplyr::lead(df1[ranks, "LAT"], n = 1L, default = NA)
  nextLon <- dplyr::lead(df1[ranks, "LON"], n = 1L, default = NA)


  data_list <- list(ranks = ranks, nextLat = nextLat, nextLon = nextLon)
  names(data_list) <- c("ranks", "next_Lat","next_Lon")
  return(data_list)

}
