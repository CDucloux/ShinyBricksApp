#' Récupère le nom pour un ensemble spécifique.
#'
#' Cette fonction prend un dataframe contenant les informations sur les ensembles et récupère le nom pour un ensemble spécifique, identifié par son numéro de set.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles.
#' @param input_set_number Le numéro de set pour lequel récupérer le nom.
#' @return Le nom de l'ensemble spécifié.
#' @importFrom dplyr filter select pull
#' @export
set_name <- function(df_prices, input_set_number){
  return(
    df_prices |>
      filter(set_number == input_set_number) |>
      select(name) |>
      pull()
  )
}
