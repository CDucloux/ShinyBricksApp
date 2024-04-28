## code to prepare `df_instructions` dataset goes here
df_instructions <- arrow::read_parquet("data/instructions.parquet")
usethis::use_data(df_instructions, overwrite = TRUE)
