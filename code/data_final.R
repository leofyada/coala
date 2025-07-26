#--------------------------
#- FINAL DATA PREPARATION - 
#--------------------------

# Importing functions
source("code/functions.R")

# Preparing final data
final_data <- prepare_final_data(df_bid = clean_data_formatted, df_p1 = df_product1)
final_data <- merge(x=final_data, y=df_product1 %>% select(country, country_acronym), by="country_acronym")
# Exporting final data
data.table::fwrite(x = final_data, file = here("clean_data", "final_data.csv"))
writexl::write_xlsx(x = final_data, path = here("clean_data", "final_data.xlsx"))
