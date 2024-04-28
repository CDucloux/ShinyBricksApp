#' pricing_licensed
#'
#' Cette fonction génère un graphique plotly permettant d'analyser l'évolution des sets
#' par année selon qu'ils soient sous licence ou non.
#'
#' @param df_prices le dataframe principal
#' @importFrom dplyr mutate case_when group_by count filter
#' @export
pricing_licensed <- function(df_prices){
  return(
    df_prices |>
      mutate(
        themeGroup = case_when(
          themeGroup != "Licensed" ~ "Sans Licence",
          .default = "Avec Licence"
        )
      ) |>
      group_by(themeGroup, year) |>
      count() |>
      filter(!is.na(themeGroup)) |>
      plot_ly(
        x = ~year,
        y = ~n,
        type = "scatter",
        mode = "line",
        color = ~themeGroup,
        hovertemplate = paste(
          "<b>Nombre de sets</b> : %{y}",
          "<extra></extra>"
        )
      ) |>
      layout(
        hovermode = "x",
        yaxis = list(title = "", zeroline = FALSE),
        xaxis = list(title = "", zeroline = FALSE),
        font = list(family = "PT Sans"),
        hoverlabel = list(
          bordercolor = "lightgrey", # Couleur de la bordure du tooltip
          font = list(family = "PT Sans", color = 'white')
        ),
        margin = list(l = 40, r = 40, b = 40, t = 40)
      ) |>
      config(displayModeBar = FALSE)
  )
}
