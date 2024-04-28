year_mean_pieces <- function(df_prices, year_input){
  year_mean_pieces <- df_prices |> 
    filter(year == year_input) |> 
    select(pieces) |> 
    summarise(
      mean = mean(pieces, na.rm = TRUE)
    ) |> 
    pull() |> 
    round()
  
  return(glue::glue("<b>Nombre moyen de pièces</b> : {year_mean_pieces}"))
}