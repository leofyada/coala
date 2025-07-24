#-------------------
#- RAW DATA IMPORT - 
#-------------------

# Importing functions
source("code/functions.R")
# Importing BID files per country
country_dfs <- import_raw_data()
# Importing product 1 excel file
df_product_final <- readxl::read_xlsx(here("raw_data", "20250611_base_final.xlsx"))
df_product1 <- data.table::fread(here("raw_data", "20250514_calculadora_1.csv"))

