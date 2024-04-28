set_value_new <- function(df_prices, input_set_number){
  return(
    df_prices |> 
      filter(set_number == input_set_number) |>
      select(value_new) |>
      pull()
  )
}
