## code to prepare `df_prices` dataset goes here

parquet_files <- list.files(
  "data/sets",
  pattern = "sets.*\\.parquet$",
  full.names = TRUE
)

feather_files <- list.files(
  "data/scrap",
  pattern = "\\.feather$",
  full.names = TRUE
)

df_sets <- purrr::map_dfr(parquet_files, ~ arrow::read_parquet(.x))

df_sets <- df_sets |>
  dplyr::filter(category %in% c("Normal", "Extended", "Collection")) |>
  dplyr::mutate(set_number = glue::glue("{number}-{numberVariant}")) |>
  dplyr::mutate(
    brickeconomy_link = glue::glue("https://www.brickeconomy.com/set/{set_number}/")
  )

df_scrap <- purrr::map_dfr(feather_files, ~ feather::read_feather(.x))

df_prices <- inner_join(
  df_sets,
  df_scrap,
  by = join_by(set_number, brickeconomy_link)
) |>
  tidyr::drop_na(retail_price) |>
  mutate(
    diff_new_retail = value_new / retail_price,
    diff_used_retail = value_used / retail_price,
    ppp = pieces / retail_price
  )

usethis::use_data(df_prices, overwrite = TRUE)
