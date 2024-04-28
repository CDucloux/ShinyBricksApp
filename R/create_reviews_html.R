#' create_stars
#'
#' Cette fonction permet de transformer la note d'un set en étoiles
#' et de l'afficher dans l'interface utilisateur. Elle vérifie d'abord
#' si la note est bien comprise entre 0 et 5 avant de passer au traitement.
#'
#' @param note La note agrégée d'un set LEGO
#' @export
create_stars <- function(note) {
  if (note >= 0 & note <= 5) {
    full_stars <- paste(rep("✭", note), collapse = " ")
    empty_stars <- paste(rep("✩", 5-note), collapse = " ")
    empty_stars <- paste("",empty_stars)
    return(glue::glue(full_stars,empty_stars))
  }
}

#' create_reviews_html
#'
#' Cette fonction permet de récupérer l'auteur, la date, le titre, le corps de la
#' review et enfin la note accordée par l'auteur au set LEGO pour être ensuite
#' envoyée dans un squelette HTML brut dans l'application.
#' Si jamais il n'y a pas de critique associée au set, alors la fonction renvoie :
#' -- Aucun avis disponible pour ce set --.
#'
#' @param df_reviews Le dataframe des critiques
#' @param input_set_number Le numéro du set LEGO
#' @importFrom dplyr filter select rowwise mutate pull
#' @export
create_reviews_html <- function(df_reviews, input_set_number) {
  result <- tryCatch({
    df_reviews |>
      filter(set_number == !!input_set_number) |>
      select(author, datePosted, title, review, overall) |>
      rowwise() |>
      mutate(
        stars = create_stars(overall)
      ) |>
      mutate(
        total_review = glue::glue(
          "
          <li class='review'>
          <div class='note'>
            <span class='text_note'>Note finale</span>
            <span class='stars'>{stars}</span>
          </div>
          <h2>{title}</h2>
          <div class='contenu_review'>
            <div class='info_user'>
              <p>Avis de <a href='https://brickset.com/news/author-{author}' rel='author'>{author}</a>, écrit le {datePosted |> stringr::str_sub(1,10)}</p>
            </div>
            <p>&nbsp;</p>
            <div class='description'>
              <p>{review}</p>
              <p>&nbsp;</p>
            </div>
          </div>
          </li>
          "
        )
      ) |>
      select(total_review) |>
      pull()
  }, error = function(e) {
    return("<h2>Aucun avis disponible pour ce set.</h2>")
  }
  )

  return(result)
}
