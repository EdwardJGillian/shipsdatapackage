server <- function(input, output, session) {

  values <- reactiveValues()

  shipsFilteredByType <- reactive({
    filteredShips <- shipsData[shipsData[, "ship_type"] == input$shipTypeSelect,]
    values$shipName <- filteredShips[1, "SHIPNAME"]
    filteredShips
  })

  output$selectShipName <- renderUI({
    shipsNames <- unique(shipsFilteredByType()["SHIPNAME"])
    selectInput(
      "shipName",
      label = "Ship Name:",
      choices = shipsNames$SHIPNAME,
      selected = shipsNames$SHIPNAME[1]
    )
  })

  observeEvent(input$shipName, {
    req(input$shipName)
    values$shipName <- input$shipName
  })


  shipDistance <- reactive({
    req(values$shipName, shipsFilteredByType())

    filteredByType <- shipsFilteredByType()
    selectedShipData <- filteredByType[filteredByType[,"SHIPNAME"] == values$shipName,]

    # create parameter list
    parameter_list <- shipsdatapackage::general_data_preprocess(selectedShipData)

    frameWithNextValues <- cbind(selectedShipData[parameter_list$ranks,], next_Lat = parameter_list$next_Lat, next_Lon = parameter_list$next_Lon)
    frameWithoutNA <- frameWithNextValues[0:(nrow(frameWithNextValues)-1),]

    distanceCalculation <- mapply(shipsdatapackage::calculate_distance, frameWithoutNA$LON, frameWithoutNA$LAT, frameWithoutNA$next_Lon, frameWithoutNA$next_Lat)

    observationsIndexes <- which(distanceCalculation == max(distanceCalculation))
    #print(observationsIndexes)
    #print(frameWithoutNA[c(observationsIndexes -1, observationsIndexes, observationsIndexes + 1),])
    lastIndex <- tail(observationsIndexes, n=1)
    cbind(frameWithoutNA[lastIndex,], distance=distanceCalculation[lastIndex])
  })

  output$map <- renderLeaflet({
    #https://stackoverflow.com/questions/37446283/creating-legend-with-circles-leaflet-r
    addLegendCustom <- function(map, colors, labels, sizes, opacity = 0.5){
      colorAdditions <- paste0(colors, "; width:", sizes, "px; height:", sizes, "px")
      labelAdditions <- paste0("<div style='display: inline-block;height: ", sizes, "px;margin-top: 4px;line-height: ", sizes, "px;'>", labels, "</div>")

      return(addLegend(map, colors = colorAdditions, labels = labelAdditions, opacity = opacity))
    }

    leaflet() %>%
      addTiles() %>%
      fitBounds(MIN_LON, MIN_LAT, MAX_LON, MAX_LAT) %>%
      addLegendCustom(colors = c("orange", "blue"), labels = c("Start", "End"), sizes = c(10, 10))
  })

  output$shipDistanceText <- renderText({
    req(shipDistance())
    paste("Ship distance in meters:", format(round(shipDistance()$distance, 0), nsmall = 0), sep=" ")
  })

  observe({
    shipDistanceVector <- shipDistance()

    leafletProxy('map') %>% # use the proxy to save computation
      clearShapes() %>%
      addCircles(lng=c(shipDistanceVector$LON),
                 lat=c(shipDistanceVector$LAT),
                 group='circles',
                 weight=1, radius=100, color='orange',
                 fillColor='orange',
                 fillOpacity=0.5,
                 opacity=1) %>%
      addCircles(lng=c(shipDistanceVector$next_Lon),
                 lat=c(shipDistanceVector$next_Lat),
                 group='circles',
                 weight=1, radius=100, color='blue',
                 fillColor='blue',
                 fillOpacity=0.5,
                 opacity=1)

  })
}

