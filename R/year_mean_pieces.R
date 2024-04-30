#' Calcule le nombre moyen de pièces pour une année donnée.
#'
#' Cette fonction calcule le nombre moyen de pièces pour une année donnée à partir des données sur les prix des sets LEGO.
#'
#' @param df_prices Le dataframe contenant les données sur les prix des sets.
#' @param year_input L'année pour laquelle calculer le nombre moyen de pièces.
#' @return Le nombre moyen de pièces pour l'année spécifiée.
#' @export
#'
#' @importFrom dplyr filter select summarise
#' @importFrom glue glue
year_mean_pieces <- function(df_prices, year_input){
  year_mean_pieces <- df_prices |>
    filter(year == year_input) |>
    select(pieces) |>
    summarise(
      mean = mean(pieces, na.rm = TRUE)
    ) |>
    pull() |>
    round()

  return(glue::glue("<b>Nombre moyen de pièces</b> : {year_mean_pieces}"))
}
