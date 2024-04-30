#' Calcule le prix moyen des sets pour une année donnée.
#'
#' Cette fonction calcule le prix moyen des sets pour une année donnée à partir des données sur les prix des sets LEGO.
#'
#' @param df_prices Le dataframe contenant les données sur les prix des sets.
#' @param year_input L'année pour laquelle calculer le prix moyen des sets.
#' @return Le prix moyen des sets pour l'année spécifiée.
#' @export
#'
#' @importFrom dplyr filter select summarise pull
year_mean_price <- function(df_prices, year_input) {
  return(
    df_prices |>
      filter(year == year_input) |>
      select(retail_price) |>
      summarise(mean_price = mean(retail_price, na.rm = TRUE)) |>
      pull() |>
      round(2)
  )
}
