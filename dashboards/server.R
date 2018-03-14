# Author: Richard Ngamita. 
# ngamita@gmail.com


shinyServer(function(input, output) {
    
    # Datasources mapping and arrangement for visualizations. 
    # Main datasource dataframe: filtered
    # Do not edit anything here. 
    pimaa_df <- reactive({
            pimaa_data %>%
            mutate(closed_at = ymd(as.Date(closed_at))) 
    })


    # Print outputs. 
    #output$input <- renderPrint({ as.list(input) })
    
    output$vb_pop <- renderValueBox({
        valueBox(
            tagList(
                # format number from the global.R
                fmtnum(nrow(pimaa_df()))
                #hcspakr
                #issue_plot
            ),
            subtitle = "Reported Issues to Date:",
            icon = icon("chart")
        )
        
    })
    
    output$table <- renderTable({
        pimaa_df()
    })
    
    
})