#' Calcule la durée de vie d'un thème LEGO spécifique.
#'
#' Cette fonction prend un dataframe contenant des informations sur les ensembles LEGO et calcule la durée de vie d'un thème LEGO spécifique en se basant sur les années de sortie des ensembles dans le dataframe.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles LEGO.
#' @param theme_input Le thème LEGO pour lequel calculer la durée de vie.
#' @return La durée de vie du thème LEGO spécifié.
#' @export
theme_lifespan <- function(df_prices, theme_input) {
  theme_lifespan <- df_prices |>
    dplyr::filter(theme == theme_input) |>
    dplyr::select(year) |>
    dplyr::summarise(min = min(year), max = max(year)) |>
    tidyr::unite("theme_lifespan", min, max, sep = "–") |>
    dplyr::pull()
  return(
    glue::glue(
      "<b>Durée de vie du thème</b> : {bs_icon('calendar-range')} {theme_lifespan}"
    )
  )
}
