#' get_3D_link
#'
#' Cette fonction permet de créer le lien de visualisation 3D du site Mecabricks
#' Utilisée seule, elle ne vérifie pas l'existence ou non du lien. En effet,
#' certains sets n'ont pas de visualisation 3D associée.
#'
#' @param set_number Le numéro du set LEGO
#' @export
get_3D_link <- function(set_number){
  return(glue::glue("https://www.mecabricks.com/en/player/{set_number}"))
}
