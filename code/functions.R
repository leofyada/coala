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
    if (!(folder %in% c("LAC", "BRB", "TTO"))) {
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

#---------------------------
#- CLEANING FILES FUNCTION - 
#---------------------------

# 1. Function to clean dataframes
clean_raw_data <- function(df_list) {
  
  # Initialize an empty data frame to accumulate results
  df_clean <- data.frame()
  
  # Loop over each data frame in the input list
  for(df in df_list){
    
    # Extract country-level identifiers from the first row
    # Then group by these identifiers and summarise all numeric columns
    df <- df %>% 
      mutate(
        ADM0_EN = as.character(df[1, 1]),   # Country name from first row, first column
        ADM0_PCODE = as.character(df[1, 2]) # Country code from first row, second column
      ) %>% 
      group_by(ADM0_EN, ADM0_PCODE) %>%
      summarise(
        across(where(is.numeric), \(x) sum(x, na.rm = TRUE)),  # Sum all numeric columns
        .groups = "drop"  # Drop grouping after summarise
      )
    
    # Append the cleaned and summarised df to the master data frame
    df_clean <- bind_rows(df_clean, df)
  }
  
  # Drop unused location code columns, if present
  df_clean <- df_clean %>% 
    select(-c(cod_canton, codigo_distrito, codigo_departamento))
  
  # Return the cleaned and aggregated data
  return(df_clean)
}

