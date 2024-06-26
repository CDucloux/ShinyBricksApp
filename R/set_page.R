#' Récupère l'URL de la page Brickset pour un ensemble spécifique.
#'
#' Cette fonction prend un dataframe contenant les informations sur les ensembles et récupère l'URL de la page Brickset pour un ensemble spécifique, identifié par son numéro de set.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles.
#' @param input_set_number Le numéro de set pour lequel récupérer l'URL de la page Brickset.
#' @return L'URL de la page Brickset pour l'ensemble spécifié.
#' @importFrom dplyr filter select pull
#' @export
set_page <- function(df_prices, input_set_number){
  return(
    df_prices |>
      filter(set_number == input_set_number) |>
      select(bricksetURL) |>
      pull()
  )
}
