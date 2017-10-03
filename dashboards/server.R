# Richard Ngamita
# ngamita@gmail.com
# PiMaa Project Dashboard Visualizations and Graphs. 

# Load Libraries to be used. 
library(shiny)

# server.R
function(input, output, session){
  output$table <- DT::renderDataTable({
    query <- sqlInterpolate(ANSI(), "SELECT * FROM readings WHERE node_id = ?node LIMIT 1000;",
                            node = input$node)
    outp <- dbGetQuery(pool, query)
    ret <- DT::datatable(outp)
    return(ret)
  })
}