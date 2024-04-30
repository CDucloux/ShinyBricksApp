#' Récupère le prix de détail d'un ensemble spécifique.
#'
#' Cette fonction prend un dataframe contenant les informations sur les ensembles et renvoie le prix de détail d'un ensemble spécifique, identifié par son numéro de set.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles.
#' @param input_set_number Le numéro de set pour lequel récupérer le prix de détail.
#' @return Le prix de détail de l'ensemble spécifié.
#' @export
set_retail_price <- function(df_prices, input_set_number){
  return(
    df_prices |>
      filter(set_number == input_set_number) |>
      select(retail_price) |>
      pull()
  )
}
