set_pieces_number <- function(df_prices, input_set_number){
  set_pieces <- df_prices |> 
      filter(set_number == input_set_number) |>
      select(pieces) |>
      pull()
  
  return(glue::glue("<b>Nombre de pièces</b> : {set_pieces}"))
  
}


