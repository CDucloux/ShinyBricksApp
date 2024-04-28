theme_median_age <- function(df_prices, theme_input){
  median_age <- df_prices |> 
    filter(theme == theme_input) |> 
    select(agerange_min) |>
    pull() |> 
    median(na.rm = TRUE) |>
    ceiling()

  median_age_format <- if_else(
    median_age |> is.na(),
    "<b>Age médian recommandé</b> : Indisponible",
    glue::glue("<b>Age médian recommandé</b> : {median_age} ans")
  )
  return(median_age_format)
}
