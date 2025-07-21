#-------------
#- FUNCTIONS - 
#-------------

# Getting the raw data directory
dirs <- list.dirs(here("raw_data"), recursive = FALSE, full.names = FALSE)
# Function to import csv files from directories
data_import_fun <- function(){
  # Creating an empty list to receive dataframes
  result <- list()
  for(dir in dirs){
    # Getting the directory with here function
    directory = here("raw_data")
    # LAC doesn't have any csv file
    if(dir != "LAC"){
      # Establishing directory path to csv files
      path = glue("{directory}/{dir}/{dir}.csv")
      # Creating a name for dataframe
      df_name <- glue("df_{dir}")
      # Reading csv files
      df_data <- data.table::fread(path, fill=TRUE)
      # Inserting dataframe in list
      result[[df_name]] <- df_data
    }
  }
  # Returning list of data
  return(result)
}


