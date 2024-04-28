theme_mean_price_new <- function(df_prices, theme_input){
  return(
    df_prices |> 
      filter(theme == theme_input) |> 
      select(value_new) |> 
      summarise(mean_value_new = mean(value_new, na.rm = TRUE)) |> 
      pull() |> 
      round(2)
  )
}
