library(shiny)
library(shiny.semantic)
library(leaflet)
library(geosphere)
library(dplyr)
library(shipsdatapackage)

# set the home environment
home <- setwd(Sys.getenv("HOME"))

# set the file path and file name
rds_file_path <- file.path(home, "extdata/ships.rds")

# load ships data
ships_data <- readRDS(rds_file_path)

# set up the ship types and minimum and maximum latitude and longitude
ships_types <- unique(ships_data["ship_type"])
min_lat <- min(ships_data["LAT"])
max_lat <- max(ships_data["LAT"])
min_lon <- min(ships_data["LON"])
max_lon <- max(ships_data["LON"])
