year_blocktext <- function(df_prices, year_input){
  return(
    glue::glue(
      "Cet onglet contient des informations sur les sorties LEGO en {year_input}.")
  )
}
