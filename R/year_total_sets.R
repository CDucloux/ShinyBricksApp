year_total_sets <- function(df_prices, year_input){
  year_total_sets <- df_prices |> 
    filter(year == year_input) |> 
    count() |> 
    pull()
  
  return(glue::glue("<b>Nombre total de sets</b> : {year_total_sets}"))
}
