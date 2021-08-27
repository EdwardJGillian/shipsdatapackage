library(shipsdatapackage)

server <- function(input, output, session) {

  values <- reactiveValues()

  ships_filtered_by_type <- reactive({
    filtered_ships <- ships_data[ships_data[, "ship_type"] == input$ship_type_select,]
    values$ship_name <- filtered_ships[1, "SHIPNAME"]
    filtered_ships
  })

  output$select_ship_name <- renderUI({
    ships_names <- unique(ships_filtered_by_type()["SHIPNAME"])
    selectInput(
      "ship_name",
      label = "Ship Name:",
      choices = ships_names$SHIPNAME,
      selected = ships_names$SHIPNAME[1]
    )
  })

  observeEvent(input$ship_name, {
    req(input$ship_name)
    values$ship_name <- input$ship_name
  })


  ship_distance <- reactive({
    req(values$ship_name, ships_filtered_by_type())

    filtered_by_type <- ships_filtered_by_type()
    selected_ship_data <- filtered_by_type[filtered_by_type[,"SHIPNAME"] == values$ship_name,]

    # create parameter list
    parameter_list <- shipsdatapackage::general_data_preprocess(selected_ship_data)

    frame_with_next_values <- cbind(selected_ship_data[parameter_list$ranks,], next_lat = parameter_list$next_lat, next_lon = parameter_list$next_lon)
    frame_without_na <- frame_with_next_values[0:(nrow(frame_with_next_values) -1),]

    distance_calculation <- mapply(shipsdatapackage::calculate_distance, frame_without_na$LON, frame_without_na$LAT, frame_without_na$next_lon, frame_without_na$next_lat)

    observations_indexes <- which(distance_calculation == max(distance_calculation))
    last_index <- tail(observations_indexes, n=1)
    cbind(frame_without_na[last_index,], distance=distance_calculation[last_index])
  })

  output$map <- renderLeaflet({
    #https://stackoverflow.com/questions/37446283/creating-legend-with-circles-leaflet-r
    addLegendCustom <- function(map, colors, labels, sizes, opacity = 0.5){
      colorAdditions <- paste0(colors, "; width:", sizes, "px; height:", sizes, "px")
      labelAdditions <- paste0("<div style='display: inline-block;height: ", sizes, "px;margin-top: 4px;line-height: ", sizes, "px;'>", labels, "</div>")

      return(addLegend(map, colors = colorAdditions, labels = labelAdditions, opacity = opacity))
    }

    leaflet::leaflet() %>%
      leaflet::addTiles() %>%
      leaflet::fitBounds(min_lon, min_lat, max_lon, max_lat) %>%
      addLegendCustom(colors = c("orange", "blue"), labels = c("Start", "End"), sizes = c(10, 10))
  })

  output$ship_distance_text <- renderText({
    req(ship_distance())
    paste("Ship distance in meters:", format(round(ship_distance()$distance, 0), nsmall = 0), sep = " ")
  })

  observe({
    ship_distance_vector <- ship_distance()

    leafletProxy('map') %>% # use the proxy to save computation
      clearShapes() %>%
      addCircles(lng = c(ship_distance_vector$LON),
                 lat = c(ship_distance_vector$LAT),
                 group ='circles',
                 weight = 1, radius = 100, color = 'orange',
                 fillColor = 'orange',
                 fillOpacity = 0.5,
                 opacity = 1) %>%
      addCircles(lng = c(ship_distance_vector$next_lon),
                 lat = c(ship_distance_vector$next_lat),
                 group = 'circles',
                 weight = 1, radius = 100, color = 'blue',
                 fillColor = 'blue',
                 fillOpacity = 0.5,
                 opacity = 1)

  })
}

