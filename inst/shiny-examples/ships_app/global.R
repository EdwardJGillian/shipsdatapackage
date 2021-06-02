library(shiny)
library(shiny.semantic)
library(leaflet)
library(geosphere)
library(dplyr)


home <- setwd(Sys.getenv("HOME"))

rds_file_path <- file.path(home, "extdata/ships.rds")

shipsData <- readRDS(rds_file_path)

shipsTypes <- unique(shipsData["ship_type"])
MIN_LAT <- min(shipsData["LAT"])
MAX_LAT <- max(shipsData["LAT"])
MIN_LON <- min(shipsData["LON"])
MAX_LON <- max(shipsData["LON"])

