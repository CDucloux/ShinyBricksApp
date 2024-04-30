#' Calcule le nombre moyen de pièces pour un thème LEGO spécifique.
#'
#' Cette fonction prend un dataframe contenant des informations sur les ensembles LEGO et calcule le nombre moyen de pièces pour un thème LEGO spécifique.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles LEGO.
#' @param theme_input Le thème LEGO pour lequel calculer le nombre moyen de pièces.
#' @return Le nombre moyen de pièces pour le thème LEGO spécifié.
#' @export
theme_mean_pieces <- function(df_prices, theme_input) {
  theme_mean_pieces <- df_prices |>
    dplyr::filter(theme == theme_input) |>
    dplyr::select(pieces) |>
    dplyr::summarise(mean = mean(pieces, na.rm = TRUE)) |>
    dplyr::pull() |>
    round()
  return(glue::glue("<b>Nombre moyen de pièces</b> : {theme_mean_pieces}"))
}
