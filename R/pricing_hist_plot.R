#' pricing_hist_plot
#'
#' Cette fonction permet de créer un histogramme plotly interactif dont l'objectif
#' va être de visualiser le nombre de sets LEGO compris dans des tranches de 10€
#' de 0 à 450€.
#'
#' @param df_prices Le dataframe principal
#' @importFrom dplyr filter
#' @export
pricing_hist_plot <- function(df_prices){
  return (
    df_prices |>
      filter(retail_price < 450) |>
      plot_ly(
        x = ~retail_price,
        type = "histogram",
        nbinsx = 60,
        hovertemplate = paste(
          "<b>Nombre de sets dans cette gamme de prix</b> : %{y}",
          "<extra></extra>"
        ),
        marker = list(
          color = "#DA291C",
          opacity = 0.85,
          line = list(color = "white", width = 0.5)
        )
      ) |>
      layout(
        hovermode = "x",
        hoverlabel = list(
          bordercolor = "lightgrey", # Couleur de la bordure du tooltip
          font = list(family = "PT Sans", color = 'white')
        ),
        font = list(family = "PT Sans"),
        xaxis = list(
          title = "",
          zeroline = FALSE,
          ticksuffix=" €"
        ),
        yaxis = list(
          title = "",
          zeroline = FALSE,
          ticksuffix="  "
        ),
        margin = list(l = 40, r = 40, b = 40, t = 40)
      ) |>
      config(displayModeBar = FALSE)
  )
}
