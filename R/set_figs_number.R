#' Récupère le nombre de figurines pour un ensemble spécifique.
#'
#' Cette fonction prend un dataframe contenant les informations sur les prix des ensembles et récupère le nombre de figurines pour un ensemble spécifique, identifié par son numéro de set.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles.
#' @param input_set_number Le numéro de set pour lequel récupérer le nombre de figurines.
#' @return Le nombre de figurines pour l'ensemble spécifié.
#' @importFrom dplyr filter select pull if_else
#' @export
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
