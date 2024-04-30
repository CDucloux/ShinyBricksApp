#' Récupère le nombre de pièces pour un ensemble spécifique.
#'
#' Cette fonction prend un dataframe contenant les informations sur les ensembles et récupère le nombre de pièces pour un ensemble spécifique, identifié par son numéro de set.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles.
#' @param input_set_number Le numéro de set pour lequel récupérer le nombre de pièces.
#' @return Le nombre de pièces pour l'ensemble spécifié.
#' @importFrom dplyr filter select pull
#' @export
set_pieces_number <- function(df_prices, input_set_number){
  set_pieces <- df_prices |>
      filter(set_number == input_set_number) |>
      select(pieces) |>
      pull()
  return(glue::glue("<b>Nombre de pièces</b> : {set_pieces}"))
}
