#' Récupère la valeur d'un ensemble d'occasion spécifique.
#'
#' Cette fonction prend un dataframe contenant les informations sur les ensembles et renvoie la valeur d'un ensemble d'occasion spécifique, identifié par son numéro de set.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles.
#' @param input_set_number Le numéro de set pour lequel récupérer la valeur d'occasion.
#' @return La valeur d'occasion de l'ensemble spécifié.
#' @export
set_value_used <- function(df_prices, input_set_number){
  set_value_used <- df_prices |>
    filter(set_number == input_set_number) |>
    select(value_used) |>
    pull()
}
