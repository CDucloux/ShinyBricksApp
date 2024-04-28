set_name <- function(df_prices, input_set_number){
  return(
    df_prices |> 
      filter(set_number == input_set_number) |>
      select(name) |>
      pull()
  )
}
  