theme_total_sets <- function(df_prices, theme_input){
  theme_total_sets <- df_prices |> 
    filter(theme == theme_input) |> 
    count() |> 
    pull()
  
  return(glue::glue("<b>Nombre total de sets</b> : {theme_total_sets}"))
}
