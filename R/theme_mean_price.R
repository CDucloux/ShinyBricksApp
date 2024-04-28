theme_mean_price <- function(df_prices, theme_input){
  return(
    df_prices |> 
      filter(theme == theme_input) |> 
      select(retail_price) |> 
      summarise(mean_price = mean(retail_price, na.rm = TRUE)) |> 
      pull() |> 
      round(2)
  )
}
