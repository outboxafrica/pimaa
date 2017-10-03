# Richard Ngamita
# ngamita@gmail.com
# General scripts for the PiMaa dashboards. 

# TODO: Always run the mysql_connect.R to get the DF 

head(df)


# http://stackoverflow.com/questions/3777174/plotting-two-variables-as-lines-using-ggplot2-on-the-same-graph
# 
ggplot(df, aes(x=(timestamp), y=value, colour=description)) +
  geom_line()


set.seed(1234)
dat <- data.frame(cond = factor(rep(c("A","B"), each=200)), 
                  rating = c(rnorm(200),rnorm(200, mean=.8)))
# df 
test_data <-
  data.frame(
    var0 = 100 + c(0, cumsum(runif(49, -20, 20))),
    var1 = 150 + c(0, cumsum(runif(49, -10, 10))),
    date = seq(as.Date("2002-01-01"), by="1 month", length.out=100)
  )

ggplot(test_data, aes(date)) + 
  geom_line(aes(y = var0, colour = "var0")) + 
  geom_line(aes(y = var1, colour = "var1"))



# Overlaid histograms
ggplot(df, aes(x=value, fill=description)) +
  geom_histogram(binwidth=.5, alpha=.5, position="identity")





library(ggplot2)
library(tidyr)

test_data <-
  data.frame(
    var0 = 100 + c(0, cumsum(runif(49, -20, 20))),
    var1 = 150 + c(0, cumsum(runif(49, -10, 10))),
    date = seq(as.Date("2002-01-01"), by="1 month", length.out=100)
  )

test_data %>%
  gather(key,value, var0, var1) %>%
  ggplot(aes(x=date, y=value, colour=key)) +
  geom_line()




library("reshape2")
library("ggplot2")

test_data_long <- melt(test_data, id="date")  # convert to long format

ggplot(data=test_data_long,
       aes(x=date, y=value, colour=variable)) +
  geom_line()



library(ggplot2)
dfr <- data.frame(x = rlnorm(100, sdlog = 3))




# Select on Hum and Temperature. 
# TODO: Richard --> Fix this with dplyr quite slow. 
df_dh <- df[, c('description', 'value', 'timestamp')]
df_rt <- df_dh[df_dh$description %in% c('Temperature','Relative Humidity'),]


# Getting the right barplots.
# General Barplot here for Hum and Temps. 

lp_a <- ggplot(data=df_rt,
             aes(x=as.Date(timestamp), y=value, colour=description)) +
  geom_line(size = 2)
print(lp_a)


# Getting the right barplots.
# General Barplot here for Hum and Temps. 
df_n <- df_dh[df_dh$description %in% c('Noise Level'),]
lp_n <- ggplot(data=df_n,
               aes(x=as.Date(timestamp), y=value, colour=description)) +
  geom_line(size = 2)
print(lp_n)


# Boxplots of the data. with Outliers. 
bp <- ggplot(df, aes(x=description, y=value, color = description)) + 
  geom_boxplot() +
  theme(legend.position = 'none')
print(bp)


# Boxplots of the data.Remove Outliers. 
bp_o <- ggplot(df_rt, aes(x=description, y=value, color = description)) + 
  geom_boxplot() +
  theme(legend.position = 'none')
print(bp_o)

# Boxplots of the data.Remove Outliers. 
bp_n <- ggplot(df_rt, aes(x=description, y=value, color = description)) + 
  geom_boxplot(outlier.shape = NA) +
  theme(legend.position = 'none')
print(bp_n)




