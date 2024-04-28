set_figs_number <- function(df_prices, input_set_number){
  set_figs <- df_prices |>
    filter(set_number == input_set_number) |>
    select(minifigs) |>
    pull()

  return(
    if_else(
      is.na(set_figs),
      glue::glue("<b>Nombre de figurines</b> : Aucune"),
      glue::glue("<b>Nombre de figurines</b> : {set_figs}")
    )
  )

}
