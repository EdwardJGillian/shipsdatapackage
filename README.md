ShipsDataPackage
================
Edward Gillian
27/05/2021

-----

<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

<!-- badges: end -->

The `shipsdatapackage` has a number of goals:

Firstly, this package uses `shiny.semantic` package from `Appsilon` to
provide the ui interface.

Secondly, this package uses reactivity to get ship type and ship name
input from the `ui` to display data about ship maximum distance and the
start and end of ship movements.

Lastly, automated testing is done through chained test functions using
`testthat`. These functions allow the developer to add different input
files to test the functions stored in the `R` folder to be tested for
reliable outputs. The functions use `expect_known_value` to generate the
test outputs.

## Installation

You can install the released version of `shipsdatapackage` with:

``` r
devtools::install_github("EdwardJGillian/shipsdatapackage")
```

## Embedded Application

You can see the `shipsdatapackage` embedded in this document:

    #> [1] "C:/Users/gillian_e/Documents/R/win-library/4.0/shipsdatapackage/shiny-examples/ships_app"
    #> Loading required package: shiny
    #> Warning: package 'shiny' was built under R version 4.0.5
    #> Warning: package 'shiny.semantic' was built under R version 4.0.5
    #> 
    #> Attaching package: 'shiny.semantic'
    #> The following objects are masked from 'package:shiny':
    #> 
    #>     actionButton, checkboxInput, dateInput, fileInput, flowLayout,
    #>     icon, incProgress, modalDialog, numericInput, Progress,
    #>     removeModal, removeNotification, selectInput, setProgress,
    #>     showNotification, sliderInput, splitLayout, textAreaInput,
    #>     textInput, updateActionButton, updateSelectInput,
    #>     updateSliderInput, verticalLayout, withProgress
    #> The following object is masked from 'package:graphics':
    #> 
    #>     grid
    #> The following object is masked from 'package:utils':
    #> 
    #>     menu
    #> Warning: package 'leaflet' was built under R version 4.0.5
    #> Warning: package 'geosphere' was built under R version 4.0.5
    #> 
    #> Attaching package: 'geosphere'
    #> The following object is masked from 'package:shiny':
    #> 
    #>     span
    #> Warning: package 'dplyr' was built under R version 4.0.5
    #> 
    #> Attaching package: 'dplyr'
    #> The following objects are masked from 'package:stats':
    #> 
    #>     filter, lag
    #> The following objects are masked from 'package:base':
    #> 
    #>     intersect, setdiff, setequal, union
    #> 
    #> Listening on http://127.0.0.1:8524

<img src="man/figures/README-ships_data-1.png" width="100%" />

## Running the package

You can run `shipsdatapackage` by opening `global.R` in
`shipsdatapackage/inst/shiny-examples/ships_app/`

or type in the console:

``` r
shipsdatapackage::runShipExample()
```
