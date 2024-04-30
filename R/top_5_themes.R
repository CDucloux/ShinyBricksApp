#' Sélectionne les cinq thèmes les plus populaires.
#'
#' Cette fonction sélectionne les cinq thèmes les plus populaires en fonction du nombre de sets dans le dataframe des prix.
#'
#' @param df_prices Le dataframe contenant les données sur les prix des sets.
#' @return Un vecteur contenant les noms des cinq thèmes les plus populaires.
#' @export
top_5_themes <- function(df_prices) {
  return(
    df_prices |>
      dplyr::group_by(theme) |>
      dplyr::summarise(nb_sets = dplyr::n()) |>
      dplyr::arrange(desc(nb_sets)) |>
      dplyr::top_n(5, nb_sets) |>
      dplyr::select(theme) |>
      dplyr::pull()
  )
}
