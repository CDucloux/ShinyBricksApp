## code to prepare `df_reviews` dataset goes here
library(dplyr)

df_reviews <- arrow::read_parquet("data/reviews.parquet")
df_reviews <- df_reviews |> select(
  set_number, author, datePosted, title, review, overall, reviewCount
)
usethis::use_data(df_reviews, overwrite = TRUE)
