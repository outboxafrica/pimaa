# Dashboard Statistics for the PiMaa Project. 
# Air Quality Monitoring Project for Kampala. 
# Author: Richard Ngamita. 
# ngamita@gmail.org

dashboardPage(
    dashboardHeader(disable = TRUE),
    dashboardSidebar(disable = TRUE),
    dashboardBody(
        tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
        fluidRow(
            column(
                4, offset = 4,
                
                dateRangeInput('dateRange',
                               label = paste('Select Dates:'),
                               start = Sys.Date() - 5, end = Sys.Date(),
                               separator = " - ", format = "dd/mm/yy",
                               startview = 'year', language = 'en', weekstart = 1
                )
            )
        ),
        fluidRow(
            column(
                7,
                tableOutput("table"),
                plotOutput("barstateplot")
            ),
            column(
                5,
                column(
                    12,
                    valueBoxOutput("DateRange", width = 12),
                    valueBoxOutput("issueplot", width = 12),
                    valueBoxOutput("vb_pop", width = 12)
                   # valueBoxOutput("vb_pop_sel", width = 12),
                   # valueBoxOutput("vb_age_avg", width = 12),
                   # valueBoxOutput("vb_ratio", width = 12)
                )
            )
        ),
        fluidRow(
            column(5, verbatimTextOutput("input")),
            column(5, offset = 1, gsub("<p><img src=\".*\"/></p>", "", includeMarkdown("README.md")))
        )
    )
)