#' Récupère le prix par pièce pour un ensemble spécifique.
#'
#' Cette fonction prend un dataframe contenant les informations sur les ensembles et récupère le prix par pièce pour un ensemble spécifique, identifié par son numéro de set.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles.
#' @param input_set_number Le numéro de set pour lequel récupérer le prix par pièce.
#' @return Le prix par pièce pour l'ensemble spécifié.
#' @importFrom dplyr filter select mutate pull
#' @importFrom glue glue
#' @export
set_ppp <- function(df_prices, input_set_number){
  set_ppp <- df_prices |>
    filter(set_number == input_set_number) |>
    select(retail_price,pieces) |>
    mutate(ppp = retail_price/pieces) |>
    round(2) |>
    pull()
  return(glue::glue("<b>Prix par pièce</b> : {set_ppp} €/pièce"))
}
