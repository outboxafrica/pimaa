# Richard Ngamita
# ngamita@gmail.com
# global.R file for the shiny app
# All SERVER SIDE SETTINGS: PLEASE DON'T CHECK THIS INTO GITHUB!!!!!

# This app is developed to help in visualising the airquality dataset in R
# To be improved to pull in PiMaa data for monitoring airquality in Kampala. 

library(shiny)
library(dplyr)
library(RMySQL)
library(DT)
library(plotly)
library(rjson)
library(pool)




pool <- dbPool(
  drv = RMySQL::MySQL(),
  dbname = "**",
  host = "***",
  user = "***",
  password = "***",
  idleTimeout = 3600000
)
onStop(function() {
  poolClose(pool)
})

