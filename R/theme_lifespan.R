theme_lifespan <- function(df_prices, theme_input){
  theme_lifespan <- df_prices |>
    filter(theme == theme_input) |> 
    select(year) |> 
    summarise(min = min(year), max = max(year)) |> 
    tidyr::unite("theme_lifespan", min, max, sep = "–") |> 
    pull()
  
  return(glue::glue("<b>Durée de vie du thème</b> : {bs_icon('calendar-range')} {theme_lifespan}"))
}
