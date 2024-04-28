#' import_all_parquets
#'
#' Cette fonction permet de lister puis d'importer tous les fichiers .parquet contenus dans
#' le dossier data/sets, c'est à dire l'ensemble des sets par année récupérés
#' par l'API de Bricklink.
#'
#' @param folder_path Le chemin du dossier où sont stockés les fichiers parquet
#' @importFrom dplyr filter mutate
#' @importFrom purrr map_dfr
#' @importFrom arrow read_parquet
#' @export
import_all_parquets <- function(folder_path = "data/sets") {
  parquet_files <- list.files(folder_path, pattern = "sets.*\\.parquet$", full.names = TRUE)
  df_sets <- map_dfr(parquet_files, ~ read_parquet(.x))
  df_sets <- df_sets |>
    filter(category %in% c("Normal", "Extended", "Collection")) |>
    mutate(set_number = glue::glue("{number}-{numberVariant}")) |>
    mutate(
      brickeconomy_link = glue::glue("https://www.brickeconomy.com/set/{set_number}/")
    )
  return(df_sets)
}
