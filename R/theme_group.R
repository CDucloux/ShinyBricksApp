theme_group <- function(df_prices, theme_input){
  theme_group <- df_prices |> 
    filter(theme == theme_input) |> 
    group_by(themeGroup) |> 
    count() |> 
    select(themeGroup) |>
    pull()
  
  return(glue::glue("<b>Type du thème</b> : {theme_group}"))
}