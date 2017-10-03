# Richard Ngamita
# ngamita@gmail.com
# ui.R file for the shiny app
# This app is developed to help in visualising the airquality dataset in R
# To be improved to pull in PiMaa data for monitoring airquality in Kampala.

library(shiny)
library(markdown)

shinyUI(navbarPage("PiMaa - Airquality Data",
  tabPanel("Graphs",
  
  sidebarLayout(
    sidebarPanel(
     # dateRangeInput('dateRange',
     #                label = 'Date range input: yyyy-mm-dd',
     #                start = Sys.Date() - 2, end = Sys.Date() + 2
     # ),
     h2("Select Node:"),
     textInput("node", "Enter the Node:", "N3"),
     dateRangeInput("dates", label = h3("Date range"),
                     start = "2017-01-18", end = "2014-01-30"
      
    ),
      
      h2("Histogram"),
      helpText("Select a variable to plot a histogram."),
      radioButtons("plot","Variable",
                   c("Temperature"="var0",
                     "Relative Humidity"="var1",
                     "Gas Concentration"="var2"
                   )),
      hr(),
      h3("Scatterplot with regression line"),
      helpText("Select a factor to plot and show regression line for Gas Concentration."),
        selectInput("varx", "X factor:",
                    choices =c("var0","var1")
                   )
    ),
    mainPanel(


    )
  )
),
  
  tabPanel("Tables",
     mainPanel(
        includeMarkdown("about.md"),
        DT::dataTableOutput("table")
     )
  )
)
)
