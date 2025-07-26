#-----------------
#- DATA CLEANING - 
#-----------------

# Importing functions
source("code/functions.R")
# Cleaning data
clean_data <- clean_raw_data(country_dfs)
# Selecting and renaming columns
clean_data_formatted <- clean_data %>% 
  filter(
    ADM0_EN %in% c("Belize", "Colombia", "Guyana")
  ) %>% 
  select(
    ADM0_EN,
    ADM0_PCODE, 
    escuelas_inicial_total, escuelas_primaria_total, escuelas_secundaria_total, escuelas_media_total, 
    matricula_inicial_total, matricula_primaria_total, matricula_secundaria_total, matricula_media_total, 
    docentes_inicial_total, docentes_primaria_total, docentes_secundaria_total, docentes_media_total, 
    escuelas_inicial_urbana, escuelas_inicial_rural,
    escuelas_primaria_urbana, escuelas_primaria_rural,
    escuelas_secundaria_urbana, escuelas_secundaria_rural,
    escuelas_media_urbana, escuelas_media_rural
  ) %>% 
  mutate(
    country = ADM0_EN,
    country_acronym = ADM0_PCODE,
    number_of_schools = escuelas_inicial_total+escuelas_primaria_total+escuelas_secundaria_total,
    source_number_of_schools = ifelse(is.na(number_of_schools), NA, "BID"),
    outdated_number_of_schools = ifelse(is.na(source_number_of_schools), NA, 0),
    number_of_students = matricula_inicial_total+matricula_primaria_total+matricula_secundaria_total,
    source_number_of_students = ifelse(is.na(number_of_students), NA, "BID"),
    outdated_number_of_students = ifelse(is.na(source_number_of_students), NA, 0),
    number_of_students_primary = matricula_primaria_total,
    source_number_of_students_primary = ifelse(is.na(number_of_students_primary), NA, "BID"),
    outdated_number_of_students_primary = ifelse(is.na(source_number_of_students_primary), NA, 0),
    number_of_students_secondary = matricula_secundaria_total,
    source_number_of_students_secondary = ifelse(is.na(number_of_students_secondary), NA, "BID"),
    outdated_number_of_students_secondary = ifelse(is.na(source_number_of_students_secondary), NA, 0),
    number_of_teachers = docentes_inicial_total+docentes_primaria_total+docentes_secundaria_total,
    source_number_of_teachers = ifelse(is.na(number_of_teachers), NA, "BID"),
    outdated_number_of_teachers = ifelse(is.na(source_number_of_teachers), NA, 0),
    number_of_teachers_primary = docentes_primaria_total,
    source_number_of_teachers_primary = ifelse(is.na(number_of_teachers_primary), NA, "BID"),
    outdated_number_of_teachers_primary = ifelse(is.na(source_number_of_teachers_primary), NA, 0),
    number_of_teachers_secondary = docentes_secundaria_total,
    source_number_of_teachers_secondary = ifelse(is.na(number_of_teachers_secondary), NA, "BID"),
    outdated_number_of_teachers_secondary = ifelse(is.na(source_number_of_teachers_secondary), NA, 0),
    number_of_urban_schools = escuelas_inicial_urbana+escuelas_primaria_urbana+escuelas_secundaria_urbana,
    source_number_of_urban_schools = ifelse(is.na(number_of_urban_schools), NA, "BID"),
    outdated_number_of_urban_schools = ifelse(is.na(source_number_of_urban_schools), NA, 0),
    number_of_rural_schools = escuelas_inicial_rural+escuelas_primaria_rural+escuelas_secundaria_rural,
    source_number_of_rural_schools = ifelse(is.na(number_of_rural_schools), NA, "BID"),
    outdated_number_of_rural_schools = ifelse(is.na(source_number_of_rural_schools), NA, 0)
  ) %>% 
  select(
    country,
    country_acronym,
    number_of_schools,
    source_number_of_schools,
    outdated_number_of_schools,
    number_of_students,
    source_number_of_students,
    outdated_number_of_students,
    number_of_students_primary,
    source_number_of_students_primary,
    outdated_number_of_students_primary,
    number_of_students_secondary,
    source_number_of_students_secondary,
    outdated_number_of_students_secondary,
    number_of_teachers,
    source_number_of_teachers,
    outdated_number_of_teachers,
    number_of_teachers_primary,
    source_number_of_teachers_primary,
    outdated_number_of_teachers_primary,
    number_of_teachers_secondary,
    source_number_of_teachers_secondary,
    outdated_number_of_teachers_secondary,
    number_of_urban_schools,
    source_number_of_urban_schools,
    outdated_number_of_urban_schools,
    number_of_rural_schools,
    source_number_of_rural_schools,
    outdated_number_of_rural_schools
  )

# Exporting clean data
data.table::fwrite(x = clean_data, file = here("clean_data", "bid_data.csv"))
writexl::write_xlsx(x = clean_data, path = here("clean_data", "bid_data.xlsx"))

