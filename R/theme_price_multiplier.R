theme_price_multiplier <- function(df_prices, theme_input){
  theme_mean_price <- theme_mean_price(df_prices, theme_input)
  theme_mean_price_new <- theme_mean_price_new(df_prices, theme_input)
  
  price_multiplier <- round(theme_mean_price_new/theme_mean_price, 2)
  
  price_multiplier_format <- if_else(
    price_multiplier |> is.na(),
    "<b>Multiplicateur de prix</b> : Indisponible",
    glue::glue("<b>Multiplicateur de prix</b> : x{price_multiplier}")
  )
  
  return(price_multiplier_format)
}
