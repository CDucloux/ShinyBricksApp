year_price_range <- function(df_prices, year_input){
  year_price_range <- df_prices |>
    filter(year == year_input) |> 
    select(retail_price) |> 
    summarise(
      min = min(retail_price),
      max = max(retail_price)
    ) |> 
    tidyr::unite("price_range", min, max, sep = "–") |>
    pull()
  
  price_range_format <- glue::glue("<b>Gamme de prix</b> : {year_price_range} (€)")
  
  return(price_range_format)
}