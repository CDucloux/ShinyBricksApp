#' Génère un texte descriptif pour une année donnée.
#'
#' Cette fonction génère un texte descriptif pour une année donnée, indiquant qu'il contient des informations sur les sorties LEGO pour cette année.
#'
#' @param df_prices Le dataframe contenant les données sur les prix des sets.
#' @param year_input L'année pour laquelle générer le texte descriptif.
#' @return Un texte descriptif indiquant que l'onglet contient des informations sur les sorties LEGO pour l'année spécifiée.
#' @export
year_blocktext <- function(df_prices, year_input) {
  return(
    glue::glue(
      "Cet onglet contient des informations sur les sorties LEGO en {year_input}."
    )
  )
}
