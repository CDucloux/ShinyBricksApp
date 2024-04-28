set_retail_price <- function(df_prices, input_set_number){
  return(
    df_prices |> 
      filter(set_number == input_set_number) |>
      select(retail_price) |>
      pull()
  )
}
