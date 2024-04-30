#' Détermine le type de groupe pour un thème LEGO spécifique.
#'
#' Cette fonction prend un dataframe contenant des informations sur les ensembles LEGO et détermine le type de groupe pour un thème LEGO spécifique en se basant sur les groupes de thèmes présents dans le dataframe.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles LEGO.
#' @param theme_input Le thème LEGO pour lequel déterminer le type de groupe.
#' @return Le type de groupe pour le thème LEGO spécifié.
#' @export
theme_group <- function(df_prices, theme_input) {
  theme_group <- df_prices |>
    dplyr::filter(theme == theme_input) |>
    dplyr::group_by(themeGroup) |>
    dplyr::count() |>
    dplyr::select(themeGroup) |>
    dplyr::pull()
  return(glue::glue("<b>Type du thème</b> : {theme_group}"))
}
