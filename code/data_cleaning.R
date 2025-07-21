#-----------------
#- DATA CLEANING - 
#-----------------

# Importing functions
source("code/functions.R")
# Cleaning data
clean_data <- clean_raw_data(country_dfs)
# Exporting clean data
data.table::fwrite(x = clean_data, file = here("clean_data", "bid_data.csv"))
