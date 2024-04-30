#' Récupère la valeur d'un ensemble neuf spécifique.
#'
#' Cette fonction prend un dataframe contenant les informations sur les ensembles et renvoie la valeur d'un ensemble neuf spécifique, identifié par son numéro de set.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles.
#' @param input_set_number Le numéro de set pour lequel récupérer la valeur neuf.
#' @return La valeur neuf de l'ensemble spécifié.
#' @export
set_value_new <- function(df_prices, input_set_number){
  return(
    df_prices |>
      filter(set_number == input_set_number) |>
      select(value_new) |>
      pull()
  )
}
