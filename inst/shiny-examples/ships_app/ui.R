library(shiny)
library(shiny.semantic)
library(leaflet)
library(shipsdatapackage)

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
        "ship_type_select",
        label = "Ship Type:",
        choices = ships_types$ship_type,
        selected = ships_types$ship_type[1]
        )
      ),
      h1(uiOutput("select_ship_name")),
      h2(textOutput("ship_distance_text")),
      tags$br(),
    ),
    main_panel(
      leafletOutput("map")
    )
  )
  )
)

