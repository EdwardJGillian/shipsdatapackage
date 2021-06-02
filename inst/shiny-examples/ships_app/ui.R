library(shiny)
library(shiny.semantic)
library(leaflet)

ui <- semanticPage(
  div(class = "ui raised segment",
      div(
        a(class="ui green ribbon label", "Search Ship Data by Type and Name"),
          h1(id="Search Ship Data by Type and Name", "Ship Data Package"),
      )
  ),
  div(
    style = "margin-left: 210px",
  sidebar_layout(
    sidebar_panel(
      h1(selectInput(
        "shipTypeSelect",
        label = "Ship Type:",
        choices = shipsTypes$ship_type,
        selected = shipsTypes$ship_type[1]
        )
      ),
      h1(uiOutput("selectShipName")),
      h2(textOutput("shipDistanceText")),
      tags$br(),
    ),
    main_panel(
      leafletOutput("map")
    )
  )
  )
)

