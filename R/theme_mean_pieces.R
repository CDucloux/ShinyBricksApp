theme_mean_pieces <- function(df_prices, theme_input){
  theme_mean_pieces <- df_prices |> 
    filter(theme == theme_input) |> 
    select(pieces) |> 
    summarise(
      mean = mean(pieces, na.rm = TRUE)
    ) |> 
    pull() |> 
    round()
  
  return(glue::glue("<b>Nombre moyen de pièces</b> : {theme_mean_pieces}"))
}