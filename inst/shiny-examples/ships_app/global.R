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
shipsData <- readRDS(rds_file_path)

# set up the ship types and minimum and maximum latitude and longitude
shipsTypes <- unique(shipsData["ship_type"])
MIN_LAT <- min(shipsData["LAT"])
MAX_LAT <- max(shipsData["LAT"])
MIN_LON <- min(shipsData["LON"])
MAX_LON <- max(shipsData["LON"])

