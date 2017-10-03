# Richard Ngamita
# ngamita@gmail.com
# PiMaa Project Dashboard Visualizations and Graphs. 

# Load Libraries to be used. 
library(shiny)
library(datasets)
library(ggplot2)

# Originally should run mysql_connect.R 
# All secure code there for connection to local db
# Assuming everything hosted on the same server. 

# Select on Hum and Temperature. 
# TODO: Richard --> Fix this with dplyr quite slow. 
# TODO: Richard - clean this up soon. 
df_dh <- df[, c('description', 'value', 'timestamp')]
# Variables from the dataframe df that mainly needed. 
labels_obs <- c('Temperature','Relative Humidity')

# Convert timestamp to date only. 
df$timestamp <- as.Date(df$timestamp)

#df_rt <- df_dh[df_dh$description %in% c('Temperature','Relative Humidity'),]

shinyServer(
  function(input,output){
    # time selectd. 
    output$dateRangeText  <- renderText({
      date_out <- paste("input$dateRange is", 
            paste(as.character(input$dateRange), collapse = " to ")
      )
      print(date_out)
    })
    
    
    # Getting the right barplots.
    # General Barplot here for Hum and Temps. 
    output$lineplot_a <- renderPlot({
      # Filter the data based on user selection month 
      # seq gives a sequence and here by day.
      date_seq <- seq(input$dates[1], input$dates[2], by = "day")
      # read data. 
      df_rt <- filter(df, timestamp %in% date_seq & description %in% labels_obs)
      
      lp_a <- ggplot(data=df_rt,
                     aes(x=timestamp, y=value, colour=description)) +
        geom_line(size = 2)
      print(lp_a)
    })
    
    output$lineplot_n <- renderPlot({
      # Getting the right barplots.
      # General lineplot here for Hum and Temps. 
      # pull out only Noise datasets. 
      df_n <- df_dh[df_dh$description %in% c('Noise Level'),]
      lp_n <- ggplot(data=df_n,
                     aes(x=as.Date(timestamp), y=value, colour=description)) +
        geom_line(size = 2)
      print(lp_n)
    })
    
  
    output$boxplot <- renderPlot({
      # Boxplots of the data. with Outliers. 
            bp <- ggplot(df, aes(x=description, y=value, color = description)) + 
        geom_boxplot() +
        theme(legend.position = 'none')
      print(bp)
    })

    output$boxplot_o <- renderPlot({
      # Boxplots of the data.Remove Outliers. 
      bp_o <- ggplot(df_rt, aes(x=description, y=value, color = description)) + 
        geom_boxplot() +
        theme(legend.position = 'none')
      print(bp_o)
    })
    
    output$boxplot_n <- renderPlot({
      # Boxplots of the data.Remove Outliers. 
      bp_n <- ggplot(df_rt, aes(x=description, y=value, color = description)) + 
        geom_boxplot(outlier.shape = NA) +
        theme(legend.position = 'none')
      print(bp_n)
      
      
      
    })
    
  }
)



















