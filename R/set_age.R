set_age_range <- function(df_prices, input_set_number){
  set_age_range <- df_prices |> 
    filter(set_number == input_set_number) |>
    select(agerange_min) |>
    pull()

  return(
    if_else(
      is.na(set_age_range),
      glue::glue("<b>Age recommandé</b> : Indisponible"),
      glue::glue("<b>Age recommandé</b> : {set_age_range}+")
    )
  )
  
}


