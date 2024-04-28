#' get_wordcloud_all
#'
#' Cette fonction permet de créer un nuage de mots grâce aux mots les plus fréquents
#' des avis sur un set. Le mot `set` est exclu car il sera toujours le plus fréquent.
#'
#' @param df_reviews Le dataframe des critiques
#' @param input_set_number Le numéro du set LEGO
#' @importFrom dplyr filter select pull first group_by summarise n
#' @export
get_wordcloud_all <- function(df_reviews, input_set_number) {
  if (df_reviews |>
    filter(set_number == !!input_set_number & reviewCount <= 0) |>
    select(reviewCount) |>
    pull() |>
    first() |>
    is.na()
  ) {
    words <- df_reviews |>
      filter(set_number == !!input_set_number) |>
      select(review) |>
      tidytext::unnest_tokens(
        output = word,
        input = review,
        token = "words",
        format = "html",
        to_lower = T
      ) |>
      group_by(word) |>
      summarise(
        freq = n()
      ) |>
      filter(
        !word %in% c(tidytext::stop_words$word, "set")
      )
    return(
      tryCatch(
        {
          wordcloud::wordcloud(
            words[["word"]],
            words[["freq"]],
            color = RColorBrewer::brewer.pal(8, "Dark2"),
            random.order = FALSE
          )
        },
        error = function(e) {
          return("Il est impossible de construire un nuage de mots sans avis.")
        }
      )
    )
  }
}

#' get_wordcloud_adj
#'
#' Cette fonction permet de créer un nuage de mots des adjectifs les plus fréquents
#' des avis sur un set. L'adjectif doit faire plus que 3 lettres pour être pris en compte.
#'
#' @param df_reviews Le dataframe des critiques
#' @param input_set_number Le numéro du set LEGO
#' @importFrom dplyr filter select pull first group_by summarise n
#' @export
get_wordcloud_adj <- function(df_reviews, input_set_number) {
  if (df_reviews |>
    filter(set_number == !!input_set_number & reviewCount <= 0) |>
    select(reviewCount) |>
    pull() |>
    first() |>
    is.na()
  ) {
    words <- df_reviews |>
      filter(set_number == !!input_set_number) |>
      select(review) |>
      tidytext::unnest_tokens(
        output = word,
        input = review,
        token = "words",
        format = "html",
        to_lower = T
      ) |>
      group_by(word) |>
      summarise(
        freq = n()
      ) |>
      filter(
        word %in% c(
          tidytext::parts_of_speech |>
            filter(pos %in% c("Adjective") & nchar(word) > 3) |>
            select(word) |>
            pull()
        )
      )
    return(
      tryCatch(
        {
          wordcloud::wordcloud(
            words[["word"]],
            words[["freq"]],
            color = RColorBrewer::brewer.pal(5, "OrRd"),
            random.order = FALSE
          )
        },
        error = function(e) {
          return("Il est impossible de construire un nuage de mots sans avis.")
        }
      )
    )
  }
}
