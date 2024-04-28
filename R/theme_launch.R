theme_launch <- function(df_prices, theme_input){
  return(
    df_prices |> 
      filter(theme == theme_input) |> 
      select(year) |> 
      summarise(launched_in = min(year)) |> 
      pull()
  )
}