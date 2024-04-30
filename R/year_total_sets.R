#' Calcule le nombre total de sets pour une année donnée.
#'
#' Cette fonction calcule le nombre total de sets sortis pour une année donnée en se basant sur les données de prix des sets.
#'
#' @param df_prices Le dataframe contenant les données sur les prix des sets.
#' @param year_input L'année pour laquelle calculer le nombre total de sets.
#' @return Le nombre total de sets pour l'année spécifiée.
#' @export
#'
#' @importFrom dplyr filter count
year_total_sets <- function(df_prices, year_input){
  year_total_sets <- df_prices |>
    filter(year == year_input) |>
    count() |>
    pull()
  return(glue::glue("<b>Nombre total de sets</b> : {year_total_sets}"))
}
