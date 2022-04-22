########### FIND Data Science Task #################################################################
########### April 23, 2022 #########################################################################

########## Load Libraries ##########################################################################

library(lubridate)
library(dplyr)
library(tidyverse)

########## Read in the data from GitHub and save it as data_all ###################################
url <- "https://raw.githubusercontent.com/finddx/FINDCov19TrackerData/master/processed/data_all.csv"
data <- read.csv(url)

dim(data)
names(data)
View(data)

############ Duplicating the data to keep the original data set ####################################
data2 <- data
attach(data2)
View(data2)
class(time)

############ convert the strgcharater for time to date #############################################
data2$time<-as.Date(data2$time)
class(data2$time)

############ Creating columns for month and Quarter ################################################
data2$month <- strftime(data2$time, "%Y-%m")













