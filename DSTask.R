########### FIND Data Science Task ##################################################################
########### April 23, 2022 ##########################################################################

########## Load Libraries ###########################################################################

library(lubridate)
library(dplyr)
library(tidyverse)
library(tidyr)
library(billboarder)
library(plotly)

install.packages("pacman")
install.packages("rcdimple")

########## Read in the data from GitHub and save it as data_all ######################################

url <- "https://raw.githubusercontent.com/finddx/FINDCov19TrackerData/master/processed/data_all.csv"
data <- read.csv(url)

dim(data)
names(data)
View(data)

############ Duplicating the data to keep the original data set and clean data_set ###################

data2 <- data
attach(data2)
View(data2)
class(time)
#data2[is.na(data2)] <- 0

############ converting character for time to date ###################################################

data2$time<-as.Date(data2$time)
class(data2$time)

############ Creating columns for months and quarters ################################################

data2$monthly <- strftime(data2$time, "%Y-%m")
data2$quarterly <- paste0(year(data2$time),
                         "-0",
                         quarter(data2$time))

############ Calculating the number of days countries reported tests, cases and deaths ###############

class(new_tests_orig)
class(new_cases_orig)
class(new_deaths_orig)

########### Number of days by Month #########################

days_tests_reported_monthly <- data2 %>% group_by(monthly, name) %>%
  filter(new_tests_orig > 0) %>%
  summarise(frequency = n())

days_cases_reported_monthly <- data2 %>% group_by(monthly, name) %>%
  filter(new_cases_orig > 0) %>%
  summarise(frequency = n())

days_deaths_reported_monthly <- data2 %>% group_by(monthly, name) %>%
  filter(new_deaths_orig > 0) %>%
  summarise(frequency = n())


########### Number of days by Quarter  #######################

days_tests_reported_quarterly <- data2 %>% group_by(quarterly, name) %>%
  filter(new_tests_orig > 0) %>%
  summarise(frequency = n())

days_cases_reported_quarterly <- data2 %>% group_by(quarterly, name) %>%
  filter(new_cases_orig > 0) %>%
  summarise(frequency = n())

days_deaths_reported_quarterly <- data2 %>% group_by(quarterly, name) %>%
  filter(new_deaths_orig > 0) %>%
  summarise(frequency = n())

allData_days <- list(days_tests_reported_monthly, days_cases_reported_monthly, days_deaths_reported_monthly) %>% 
  reduce(left_join, by = "name")

############ Calculating the monthly and quarterly average tests, cases and deaths ##################

class(cap_new_tests)
class(cap_new_cases)
class(cap_new_deaths)

monthly_average1000 <- aggregate(cbind(cap_new_tests, cap_new_cases, cap_new_deaths) ~ monthly + 
                                    name, data2 , mean, na.rm = TRUE)
quartely_average1000 <- aggregate(cbind(cap_new_tests, cap_new_cases, cap_new_deaths) ~ quarterly + 
                                    name, data2 , mean, na.rm = TRUE)

############ Boxplots ###############################################################################

plot_ly(data = monthly_average1000, x = name, y = cap_new_deaths, type = "box", boxpoints = "all", jitter = 0.3,
        pointpos = -1.8)
