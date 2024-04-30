#' Calcule l'âge médian recommandé pour les ensembles d'un thème LEGO spécifique.
#'
#' Cette fonction prend un dataframe contenant des informations sur les ensembles LEGO et calcule l'âge médian recommandé pour les ensembles d'un thème LEGO spécifique.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles LEGO.
#' @param theme_input Le thème LEGO pour lequel calculer l'âge médian recommandé.
#' @return L'âge médian recommandé pour les ensembles du thème LEGO spécifié.
#' @export
theme_median_age <- function(df_prices, theme_input){
  median_age <- df_prices |>
    dplyr::filter(theme == theme_input) |>
    dplyr::select(agerange_min) |>
    dplyr::pull() |>
    median(na.rm = TRUE) |>
    ceiling()

  median_age_format <- if_else(
    median_age |> is.na(),
    "<b>Age médian recommandé</b> : Indisponible",
    glue::glue("<b>Age médian recommandé</b> : {median_age} ans")
  )
  return(median_age_format)
}
