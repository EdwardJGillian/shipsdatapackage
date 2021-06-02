ShipsDataPackage
================
Edward Gillian
23/03/2021

-----

<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

<!-- badges: end -->

The `shipsdatapackage` has a number of goals:

Firstly, this package uses `shiny.semantic` package from `Appsilon` to
provide the ui interface.

Secondly, automated testing is done through chained test functions using
`testthat`. These functions allow the developer to add different input
files to test the functions stored in the `R` folder to be tested for
reliable outputs. The functions use `expect_known_value` to generate the
test outputs.

## Installation

You can install the released version of `shipsdatapackage` with:

``` r
devtools::install_github("EdwardJGillian/shipsdatapackage")
```
