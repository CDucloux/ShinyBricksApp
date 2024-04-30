#' Calcule le multiplicateur de prix pour une année donnée.
#'
#' Cette fonction calcule le multiplicateur de prix pour une année donnée en comparant le prix moyen des nouveaux sets par rapport au prix moyen des sets de détail pour cette année.
#'
#' @param df_prices Le dataframe contenant les données sur les prix des sets.
#' @param year_input L'année pour laquelle calculer le multiplicateur de prix.
#' @return Le multiplicateur de prix pour l'année spécifiée.
#' @export
#'
#' @importFrom dplyr filter select summarise
#' @seealso \code{\link{year_mean_price}}, \code{\link{year_mean_price_new}}
year_price_multiplier <- function(df_prices, year_input) {
  year_mean_price <- year_mean_price(df_prices, year_input)
  year_mean_price_new <- year_mean_price_new(df_prices, year_input)
  price_multiplier <- round(year_mean_price_new / year_mean_price, 2)
  price_multiplier_format <- if_else(
    price_multiplier |> is.na(),
    "<b>Multiplicateur de prix</b> : Indisponible",
    glue::glue("<b>Multiplicateur de prix</b> : x{price_multiplier}")
  )
  return(price_multiplier_format)
}
