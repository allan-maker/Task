########### FIND Data Science Task ################
########### April 23, 2022 ####################

# Read in the data from GitHub and save it as data_all
url <- "https://raw.githubusercontent.com/finddx/FINDCov19TrackerData/master/processed/data_all.csv"
data_all <- read.csv(url)

dim(data_all)
