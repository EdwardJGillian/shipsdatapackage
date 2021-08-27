library(shipsdatapackage)
library(testthat)

test_chained_functions <- function(csv_file) {
  test_that("check file values for parameters", {
    # naming helper
    tname <- function(n) {
      paste0(home,
             "/data/known_value/",
             csv,
             ".",
             n,
             ".test"
      )
    }

    # create file path to csv file examples

    csv_path <-
      paste0(home, "/data/csv_examples/", csv_file)
    csv <- stringr::str_remove(csv_file, ".csv")
    df1 <- readr::read_csv(file=csv_path, col_names=TRUE, col_types = readr::cols())
    shipsTypes = unique(df1["ship_type"])
    parameter_list <- shipsdatapackage::general_data_preprocess(df1)

    # SuppressWarnings used as expect_known_value is a deprecated function
    suppressWarnings(testthat::expect_known_value(
      parameter_list, tname("param_list")))

    frame_with_next_values <- cbind(df1[parameter_list$ranks,], next_lat = parameter_list$next_lat, next_lon = parameter_list$next_lon)

    frame_without_na <- frame_with_next_values[0:(nrow(frame_with_next_values)-1),]

    # rename columns by index to ensure column names are different
    frame_without_na <- frame_without_na %>%
      dplyr::rename(next_lat = 21, next_lon = 22)

    calc_distance <- mapply(shipsdatapackage::calculate_distance, frame_without_na$LON, frame_without_na$LAT, frame_without_na$next_lon, frame_without_na$next_lat)

    # SuppressWarnings used as expect_known_value is a deprecated function
    suppressWarnings(testthat::expect_known_value(
      calc_distance, tname("calc_dist")))


  })
}

# create the ALS file path
home <- setwd(Sys.getenv("HOME"))

csv_file_path <- file.path(home, "data/csv_examples")

csv_files_list <- list.files(path = csv_file_path, pattern = "*.csv$", full.names = FALSE)

# apply 1 list vector to the function
purrr::map(csv_files_list, test_chained_functions)
