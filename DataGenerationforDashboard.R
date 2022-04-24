library(tidyverse)

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


############ Calculating the monthly and quarterly average tests, cases and deaths ##################

class(cap_new_tests)
class(cap_new_cases)
class(cap_new_deaths)

monthly_average1000 <- aggregate(cbind(cap_new_tests, cap_new_cases, cap_new_deaths) ~ monthly + 
                                    name, data2 , mean, na.rm = TRUE)
quartely_average1000 <- aggregate(cbind(cap_new_tests, cap_new_cases, cap_new_deaths) ~ quarterly + 
                                    name, data2 , mean, na.rm = TRUE)

############### Generate the data #########################################################

write.csv(data_all,"C:\\Users\\aabala\\Desktop\\Task\\data_all.csv", row.names = FALSE)
write.csv(days_tests_reported_monthly,"C:\\Users\\aabala\\Desktop\\Task\\days_tests_reported_monthly.csv", row.names = FALSE)
write.csv(days_cases_reported_monthly,"C:\\Users\\aabala\\Desktop\\Task\\days_cases_reported_monthly.csv", row.names = FALSE)
write.csv(days_deaths_reported_monthly,"C:\\Users\\aabala\\Desktop\\Task\\days_deaths_reported_monthly.csv", row.names = FALSE)
write.csv(days_tests_reported_quarterly,"C:\\Users\\aabala\\Desktop\\Task\\days_tests_reported_quarterly.csv", row.names = FALSE)
write.csv(days_cases_reported_quarterly,"C:\\Users\\aabala\\Desktop\\Task\\days_cases_reported_quarterly.csv", row.names = FALSE)
write.csv(days_deaths_reported_quarterly,"C:\\Users\\aabala\\Desktop\\Task\\days_deaths_reported_quarterly.csv", row.names = FALSE)
write.csv(monthly_average1000,"C:\\Users\\aabala\\Desktop\\Task\\monthly_average1000.csv", row.names = FALSE)
write.csv(quartely_average1000,"C:\\Users\\aabala\\Desktop\\Task\\quartely_average1000.csv", row.names = FALSE)
