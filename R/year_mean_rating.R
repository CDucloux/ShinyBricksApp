year_mean_rating <- function(df_prices, year_input){
  mean_rating <- df_prices |> 
    filter(year == year_input) |> 
    select(rating) |> 
    mutate(rating = if_else(rating == 0, NA, rating)) |> 
    summarise(mean_rating = mean(rating, na.rm = TRUE)) |> 
    pull() |> 
    round(2)
  
  rating_format <- if_else(
    mean_rating |> is.na(),
    "<b>Note moyenne de l'année</b> : Indisponible",
    glue::glue("<b>Note moyenne de l'année</b> : ⭐ {mean_rating}/5")
  )
  return(rating_format)
}
