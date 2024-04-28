theme_price_range <- function(df_prices, theme_input){
  theme_price_range <- df_prices |>
    filter(theme == theme_input) |> 
    select(retail_price) |> 
    summarise(
      min = min(retail_price),
      max = max(retail_price)
    ) |> 
    tidyr::unite("price_range", min, max, sep = "–") |>
    pull()
  
  price_range_format <- glue::glue("<b>Gamme de prix</b> : {theme_price_range} (€)")
  
  return(price_range_format)
}