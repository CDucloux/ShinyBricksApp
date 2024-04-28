theme_end <- function(df_prices, theme_input){
  return(
    df_prices |> 
      filter(theme == theme_input) |> 
      select(year) |> 
      summarise(ended_in = max(year)) |> 
      pull()
  )
}
