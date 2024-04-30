#' Obtient la gamme de prix des sets pour une année donnée.
#'
#' Cette fonction récupère la gamme de prix des sets pour une année donnée à partir des données de prix des sets.
#'
#' @param df_prices Le dataframe contenant les données sur les prix des sets.
#' @param year_input L'année pour laquelle on souhaite obtenir la gamme de prix des sets.
#' @return La gamme de prix des sets pour l'année spécifiée.
#' @export
#'
#' @importFrom dplyr filter select summarise
year_price_range <- function(df_prices, year_input) {
  year_price_range <- df_prices |>
    filter(year == year_input) |>
    select(retail_price) |>
    summarise(min = min(retail_price),
              max = max(retail_price)) |>
    tidyr::unite("price_range", min, max, sep = "–") |>
    pull()
  price_range_format <-
    glue::glue("<b>Gamme de prix</b> : {year_price_range} (€)")
  return(price_range_format)
}
