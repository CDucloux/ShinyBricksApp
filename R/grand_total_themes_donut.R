#' grand_total_themes_donut
#'
#' Cette fonction permet de créer un graphique en anneau plotly interactif dont l'objectif
#' va être de visualiser la part en pourcentage des thèmes sélectionnés par l'utilisateur
#' dans l'ensemble des thèmes LEGO.
#'
#' @param df_prices Le dataframe principal
#' @param themes Les thèmes sélectionnés par l'utilisateur dans l'application
#' @importFrom dplyr mutate if_else group_by summarise n
#' @export
grand_total_themes_donut <- function(df_prices, themes){
  return(
    df_prices |>
      mutate(
        group = if_else(
        theme %in% themes,
        "Thèmes sélectionnés",
        "Autres thèmes"
        )
      ) |>
      group_by(group) |>
      summarise(number_of_sets = n()) |>
      plot_ly(
        labels = ~group,
        values = ~number_of_sets,
        opacity = 0.85
      ) |>
      add_pie(hole = 0.6, marker = list(colors = c("#FFD700", "#DA291C"))) |>
      layout(
        showlegend = FALSE,
        font = list(family = "PT Sans"),
        hoverlabel = list(
          bordercolor = "lightgrey", # Couleur de la bordure du tooltip
          font = list(family = "PT Sans", color = 'white')
        ),
        margin = list(l = 40, r = 40, b = 40, t = 40)
    ) |> config(displayModeBar = FALSE)
  )
}
