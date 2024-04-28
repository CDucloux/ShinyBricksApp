top_5_themes <- function() {
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
