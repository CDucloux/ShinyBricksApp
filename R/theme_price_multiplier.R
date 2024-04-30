#' Calcule le multiplicateur de prix moyen pour les ensembles neufs par rapport aux ensembles d'occasion d'un thème LEGO spécifique.
#'
#' Cette fonction prend un dataframe contenant des informations sur les ensembles LEGO et calcule le multiplicateur de prix moyen pour les ensembles neufs par rapport aux ensembles d'occasion d'un thème LEGO spécifique.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles LEGO.
#' @param theme_input Le thème LEGO pour lequel calculer le multiplicateur de prix.
#' @return Le multiplicateur de prix moyen pour les ensembles neufs par rapport aux ensembles d'occasion du thème LEGO spécifié.
#' @export
#' @seealso
#' \code{\link{theme_mean_price}}, \code{\link{theme_mean_price_new}}
theme_price_multiplier <- function(df_prices, theme_input) {
  theme_mean_price <- theme_mean_price(df_prices, theme_input)
  theme_mean_price_new <-
    theme_mean_price_new(df_prices, theme_input)
  price_multiplier <-
    round(theme_mean_price_new / theme_mean_price, 2)
  price_multiplier_format <- if_else(
    price_multiplier |> is.na(),
    "<b>Multiplicateur de prix</b> : Indisponible",
    glue::glue("<b>Multiplicateur de prix</b> : x{price_multiplier}")
  )
  return(price_multiplier_format)
}
