#' Calcule le prix moyen des nouveaux sets pour une année donnée.
#'
#' Cette fonction calcule le prix moyen des nouveaux sets pour une année donnée à partir des données sur les prix des sets LEGO.
#'
#' @param df_prices Le dataframe contenant les données sur les prix des sets.
#' @param year_input L'année pour laquelle calculer le prix moyen des nouveaux sets.
#' @return Le prix moyen des nouveaux sets pour l'année spécifiée.
#' @export
#'
#' @importFrom dplyr filter select summarise pull
year_mean_price_new <- function(df_prices, year_input){
  return(
    df_prices |>
      filter(year == year_input) |>
      select(value_new) |>
      summarise(mean_value_new = mean(value_new, na.rm = TRUE)) |>
      pull() |>
      round(2)
  )
}
