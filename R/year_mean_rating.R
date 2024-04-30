#' Calcule la note moyenne des sets pour une année donnée.
#'
#' Cette fonction calcule la note moyenne des sets pour une année donnée à partir des données sur les notes des sets LEGO.
#'
#' @param df_prices Le dataframe contenant les données sur les prix des sets.
#' @param year_input L'année pour laquelle calculer la note moyenne des sets.
#' @return La note moyenne des sets pour l'année spécifiée.
#' @export
#'
#' @importFrom dplyr filter select mutate summarise pull
year_mean_rating <- function(df_prices, year_input) {
  mean_rating <- df_prices |>
    filter(year == year_input) |>
    select(rating) |>
    mutate(rating = if_else(rating == 0, NA, rating)) |>
    summarise(mean_rating = mean(rating, na.rm = TRUE)) |>
    pull() |>
    round(2)
  rating_format <- if_else(
    mean_rating |> is.na(),
    "<b>Note moyenne de l'année</b> : Indisponible",
    glue::glue("<b>Note moyenne de l'année</b> : ⭐ {mean_rating}/5")
  )
  return(rating_format)
}
