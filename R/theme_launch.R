#' Détermine l'année de lancement pour un thème LEGO spécifique.
#'
#' Cette fonction prend un dataframe contenant des informations sur les ensembles LEGO et détermine l'année de lancement pour un thème LEGO spécifique en se basant sur les années des ensembles dans le dataframe.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles LEGO.
#' @param theme_input Le thème LEGO pour lequel déterminer l'année de lancement.
#' @return L'année de lancement du thème LEGO spécifié.
#' @export
theme_launch <- function(df_prices, theme_input){
  return(
    df_prices |>
      dplyr::filter(theme == theme_input) |>
      dplyr::select(year) |>
      dplyr::summarise(launched_in = min(year)) |>
      dplyr::pull()
  )
}
