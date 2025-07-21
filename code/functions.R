#----------------------------
#- IMPORTING FILES FUNCTION - 
#----------------------------

# 1. Get the names of subdirectories in "raw_data"
raw_dirs <- list.dirs(here::here("raw_data"), recursive = FALSE, full.names = FALSE)

# 2. Function to import CSV files from each subdirectory
import_raw_data <- function() {
  # Create empty list to store imported data frames
  result <- list()
  
  # Define base directory path
  base_dir <- here::here("raw_data")
  
  # Loop through each folder name in raw_dirs
  for (folder in raw_dirs) {
    # Skip "LAC" folder (it has no CSV)
    if (folder != "LAC") {
      # Construct path to CSV file
      csv_path <- file.path(base_dir, folder, paste0(folder, ".csv"))
      
      # Define name for the data frame (e.g., df_ABC)
      df_name <- paste0("df_", folder)
      
      # Check if file exists before reading (optional but safer)
      if (file.exists(csv_path)) {
        # Read CSV using fread (handles large files efficiently)
        df <- data.table::fread(csv_path, fill = TRUE, encoding="Latin-1")
        
        # Store in the result list
        result[[df_name]] <- df
      } else {
        warning(glue::glue("CSV file not found: {csv_path}"))
      }
    }
  }
  
  # Return the list of data frames
  return(result)
}


