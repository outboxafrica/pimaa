# Global connections to MySQL database. 
# Author: Richard Ngamita
# Email: ngamita@gmail.org

library(RMySQL) # TODO: Confirm this is right. 
library(DT)
library(plotly)
library(rjson)
library(pool)

# Forcefully read the Environment 
# .Renviron is to set environment variables.
# These are settings that relate to the operating system 
# for telling where to find external programs 
readRenviron("~/.Renviron")

# Launch browser on every run. 
options(
    shiny.launch.browser = TRUE
)

# Usin pool to keep db connections. 
# 
pool <- dbPool(
    drv = dbDriver("MySQL", max.con = 100), # TODO: Get driver right. 
    dbname = "pimaa",
    host = "160.153.129.223",
    port = 3306, # TODO: Get the MySQL port right. 
    user = Sys.getenv("PM_ID"),
    password = Sys.getenv("PM_PWD"),
    idleTimeout = 3600000
)

#data_maxmin <- c(round(dbGetQuery(pool,
#                                 "SELECT MAX(data), MIN(data) from t_demo;"), 3))
#id_maxmin <- c(dbGetQuery(pool,
#                         "SELECT MAX(id), MIN(id) from t_demo;"))