#' Calcule la note moyenne des ensembles pour un thème LEGO spécifique.
#'
#' Cette fonction prend un dataframe contenant des informations sur les ensembles LEGO et calcule la note moyenne des ensembles pour un thème LEGO spécifique.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles LEGO.
#' @param theme_input Le thème LEGO pour lequel calculer la note moyenne des ensembles.
#' @return La note moyenne des ensembles pour le thème LEGO spécifié.
#' @export
theme_mean_rating <- function(df_prices, theme_input) {
  mean_rating <- df_prices |>
    dplyr::filter(theme == theme_input) |>
    dplyr::select(rating) |>
    dplyr::mutate(rating = if_else(rating == 0, NA, rating)) |>
    dplyr::summarise(mean_rating = mean(rating, na.rm = TRUE)) |>
    dplyr::pull() |>
    round(2)

  rating_format <- if_else(
    mean_rating |> is.na(),
    "<b>Note moyenne du thème</b> : Indisponible",
    glue::glue("<b>Note moyenne du thème</b> : ⭐ {mean_rating}/5")
  )
  return(rating_format)
}
