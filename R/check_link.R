#' check_link
#'
#' Cette fonction permet de vérifier l'existence du lien de visualisation 3D
#' sur le site Mecabricks pour un set LEGO. Elle utilise `httr2` pour envoyer une
#' requête HTTP au site et vérifier l'état de la réponse et renvoie une exception
#' si le lien est indisponible.
#'
#' @param input_set_number Le numéro du set LEGO
#' @importFrom httr2 request req_user_agent req_perform
#' @export
check_link <- function(input_set_number){
  link <- get_3D_link(input_set_number)
  rq <- request(link) |>
    req_user_agent(
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:123.0)
      Gecko/20100101 Firefox/123.0"
    )
  return(
    tryCatch({
      response <- rq |> req_perform()
      glue::glue("HTTP {response |> httr2::resp_status()} OK.")
    },
    error = function(e){e$message}
    )
  )
}
