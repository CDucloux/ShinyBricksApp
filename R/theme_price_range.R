#' Calcule la gamme de prix des ensembles LEGO pour un thème spécifique.
#'
#' Cette fonction prend un dataframe contenant des informations sur les ensembles LEGO et calcule la gamme de prix (min-max) pour un thème LEGO spécifique.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles LEGO.
#' @param theme_input Le thème LEGO pour lequel calculer la gamme de prix.
#' @return La gamme de prix (min-max) pour le thème LEGO spécifié.
#' @export
theme_price_range <- function(df_prices, theme_input) {
  theme_price_range <- df_prices |>
    filter(theme == theme_input) |>
    select(retail_price) |>
    summarise(min = min(retail_price),
              max = max(retail_price)) |>
    tidyr::unite("price_range", min, max, sep = "–") |>
    pull()
  price_range_format <-
    glue::glue("<b>Gamme de prix</b> : {theme_price_range} (€)")
  return(price_range_format)
}
