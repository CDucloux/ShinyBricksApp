#' display_instructions
#'
#' Cette fonction permet d'afficher les instructions disponibles d'un set LEGO
#' sur le site officiel de LEGO. Elles sont ensuite affichées sous forme d'URL dans
#' l'application.
#'
#' @param df_instructions Le dataframe des instructions
#' @param input_set_number Le numéro du set LEGO
#' @importFrom dplyr filter select pull
#' @importFrom tidyr unnest_longer
#' @export
display_instructions <- function(df_instructions, input_set_number) {
  URLs <-
    df_instructions |>
    filter(set_number == input_set_number) |>
    unnest_longer(htmlURL) |>
    select(htmlURL) |>
    pull() |>
    paste(collapse = "<br>")
  return(
    glue::glue(
      "
      <h3 class='instruction_text'>Lien(s) des instructions de construction du set :</h3>
      <ul class='instructions_url'>
        {URLs}
      </ul>
      "
    )
  )
}
