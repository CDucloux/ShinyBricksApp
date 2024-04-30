#' Calcule le nombre total d'ensembles LEGO pour un thème spécifique.
#'
#' Cette fonction prend un dataframe contenant des informations sur les ensembles LEGO et calcule le nombre total d'ensembles pour un thème LEGO spécifique.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles LEGO.
#' @param theme_input Le thème LEGO pour lequel calculer le nombre total d'ensembles.
#' @return Le nombre total d'ensembles pour le thème LEGO spécifié.
#' @export
theme_total_sets <- function(df_prices, theme_input){
  theme_total_sets <- df_prices |>
    filter(theme == theme_input) |>
    count() |>
    pull()
  return(glue::glue("<b>Nombre total de sets</b> : {theme_total_sets}"))
}
