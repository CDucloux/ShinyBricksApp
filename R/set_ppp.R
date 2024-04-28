set_ppp <- function(df_prices, input_set_number){
  set_ppp <- df_prices |> 
    filter(set_number == input_set_number) |>
    select(retail_price,pieces) |>
    mutate(ppp = retail_price/pieces) |> 
    round(2) |> 
    pull()
  
  return(glue::glue("<b>Prix par pièce</b> : {set_ppp} €/pièce"))
  
}


