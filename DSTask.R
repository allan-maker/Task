########### FIND Data Science Task #################################################################
########### April 23, 2022 #########################################################################

########## Load Libraries ##########################################################################

library(lubridate)
library(dplyr)
library(tidyverse)
library(tidyr)
library(billboarder)

install.packages("pacman")
install.packages("rcdimple")

########## Read in the data from GitHub and save it as data_all ###################################
url <- "https://raw.githubusercontent.com/finddx/FINDCov19TrackerData/master/processed/data_all.csv"
data <- read.csv(url)

dim(data)
names(data)
View(data)

############ Duplicating the data to keep the original data set and clean data_set ####################
data2 <- data
attach(data2)
View(data2)
class(time)
data2[is.na(data2)] <- 0

############ converting character for time to date ###################################################
data2$time<-as.Date(data2$time)
class(data2$time)

############ Creating columns for months and quarters ################################################
data2$monthly <- strftime(data2$time, "%Y-%m")
data2$quarterly <- paste0(year(data2$time),
                         "-0",
                         quarter(data2$time))

############ Calculating the number of days countries reported tests, cases and deaths ###############
#table(data2$new_tests_orig, useNA = 'no')
class(new_tests_orig)
class(new_cases_orig)
class(new_deaths_orig)

data2 %>%
  group_by(time, name, new_tests_orig) %>%
  summarize(n = n())

############ Calculating the monthly and quarterly average tests, cases and deaths ###########

class(cap_new_tests)
class(cap_new_cases)
class(cap_new_deaths)

monthyly_average1000 <- aggregate(cbind(cap_new_tests, cap_new_cases, cap_new_deaths) ~ monthly + 
                                    name, data2 , mean, na.rm = TRUE)
quartely_average1000 <- aggregate(cbind(cap_new_tests, cap_new_cases, cap_new_deaths) ~ quarterly + 
                                    name, data2 , mean, na.rm = TRUE)




