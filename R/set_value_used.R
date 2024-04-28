set_value_used <- function(df_prices, input_set_number){
  set_value_used <- df_prices |> 
    filter(set_number == input_set_number) |>
    select(value_used) |>
    pull()
}
