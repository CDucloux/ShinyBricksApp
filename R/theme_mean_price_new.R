#' Calcule la valeur moyenne des ensembles neufs pour un thème LEGO spécifique.
#'
#' Cette fonction prend un dataframe contenant des informations sur les ensembles LEGO et calcule la valeur moyenne des ensembles neufs pour un thème LEGO spécifique.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles LEGO.
#' @param theme_input Le thème LEGO pour lequel calculer la valeur moyenne des ensembles neufs.
#' @return La valeur moyenne des ensembles neufs pour le thème LEGO spécifié.
#' @export
theme_mean_price_new <- function(df_prices, theme_input) {
  return(
    df_prices |>
      dplyr::filter(theme == theme_input) |>
      dplyr::select(value_new) |>
      dplyr::summarise(mean_value_new = mean(value_new, na.rm = TRUE)) |>
      dplyr::pull() |>
      round(2)
  )
}
