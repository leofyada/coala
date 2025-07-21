#-----------------
#- DATA CLEANING - 
#-----------------

# Importing functions
source("code/functions.R")
# Cleaning data
clean_data <- clean_raw_data(country_dfs)
# Exporting clean data
data.table::fwrite(x = clean_data, file = here("clean_data", "bid_data.csv"))
writexl::write_xlsx(x = clean_data, path = here("clean_data", "bid_data.xlsx"))

