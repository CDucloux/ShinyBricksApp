year_mean_price <- function(df_prices, year_input){
  return(
    df_prices |> 
      filter(year == year_input) |> 
      select(retail_price) |> 
      summarise(mean_price = mean(retail_price, na.rm = TRUE)) |> 
      pull() |> 
      round(2)
  )
}