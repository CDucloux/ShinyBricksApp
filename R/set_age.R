#' Récupère la tranche d'âge recommandée pour un ensemble spécifique.
#'
#' Cette fonction prend un dataframe contenant les informations sur les prix des ensembles et récupère la tranche d'âge recommandée pour un ensemble spécifique, identifié par son numéro de set.
#'
#' @param df_prices Le dataframe contenant les informations sur les prix des ensembles.
#' @param input_set_number Le numéro de set pour lequel récupérer la tranche d'âge recommandée.
#' @return La tranche d'âge recommandée pour l'ensemble spécifié.
#' @importFrom dplyr filter select pull if_else
#' @export
set_age_range <- function(df_prices, input_set_number){
  set_age_range <- df_prices |>
    filter(set_number == input_set_number) |>
    select(agerange_min) |>
    pull()
  return(
    if_else(
      is.na(set_age_range),
      glue::glue("<b>Age recommandé</b> : Indisponible"),
      glue::glue("<b>Age recommandé</b> : {set_age_range}+")
    )
  )
}
