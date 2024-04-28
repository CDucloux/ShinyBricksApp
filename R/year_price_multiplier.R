year_price_multiplier <- function(df_prices, year_input){
  year_mean_price <- year_mean_price(df_prices, year_input)
  year_mean_price_new <- year_mean_price_new(df_prices, year_input)
  
  price_multiplier <- round(year_mean_price_new/year_mean_price, 2)
  
  price_multiplier_format <- if_else(
    price_multiplier |> is.na(),
    "<b>Multiplicateur de prix</b> : Indisponible",
    glue::glue("<b>Multiplicateur de prix</b> : x{price_multiplier}")
  )
  
  return(price_multiplier_format)
}
