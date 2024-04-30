#' Génère un texte descriptif sur un thème LEGO spécifique.
#'
#' Cette fonction prend un dataframe contenant des informations sur les ensembles LEGO et génère un texte descriptif sur un thème LEGO spécifique, en indiquant l'année de lancement, l'année de fin (le cas échéant) et la durée d'existence moyenne des ensembles de ce thème.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles LEGO.
#' @param theme_input Le thème LEGO pour lequel générer le texte descriptif.
#' @return Un texte descriptif sur le thème LEGO spécifié.
#' @export
#' @seealso
#' \code{\link{theme_launch}}, \code{\link{theme_end}}, \code{\link{theme_mean_price}}
theme_blocktext <- function(df_prices, theme_input) {
  current_year <- format(Sys.Date(), "%Y")
  theme_launch <- theme_launch(df_prices, theme_input)
  theme_end <- theme_end(df_prices, theme_input)
  theme_mean_price <- theme_mean_price(df_prices, theme_input)
  sentence_part_2 <- case_when(
    theme_launch == theme_end ~ glue::glue("la commercialisation a été arrêtée la même année."),
    theme_end == current_year ~ glue::glue(
      "est toujours actif en {theme_end} avec {theme_end - theme_launch} ans d'existence."
    ),
    theme_end != current_year ~ glue::glue(
      "a été arrêté en {theme_end}, après {theme_end - theme_launch} ans d'existence."
    )
  )
  return(
    glue::glue(
      "Le thème LEGO {toupper(theme_input)} a été lancé pour la première fois en {theme_launch} et {sentence_part_2}"
    )
  )
}
