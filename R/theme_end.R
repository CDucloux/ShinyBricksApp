#' Détermine l'année de fin d'un thème LEGO spécifique.
#'
#' Cette fonction prend un dataframe contenant des informations sur les ensembles LEGO et détermine l'année de fin d'un thème LEGO spécifique en se basant sur l'année de sortie des ensembles.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles LEGO.
#' @param theme_input Le thème LEGO pour lequel déterminer l'année de fin.
#' @return L'année de fin du thème LEGO spécifié.
#' @export
theme_end <- function(df_prices, theme_input){
  return(
    df_prices |>
      dplyr::filter(theme == theme_input) |>
      dplyr::select(year) |>
      dplyr::summarise(ended_in = max(year)) |>
      dplyr::pull()
  )
}
