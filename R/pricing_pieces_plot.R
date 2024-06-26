#' Crée un graphique de dispersion des prix par rapport au nombre de pièces.
#'
#' Cette fonction prend un dataframe contenant les prix de vente au détail et le nombre de pièces de chaque set, puis crée un graphique interactif de dispersion des prix par rapport au nombre de pièces.
#'
#' @param df_prices Le dataframe contenant les prix de vente au détail et le nombre de pièces de chaque set.
#' @return Un graphique interactif de dispersion des prix par rapport au nombre de pièces.
#' @importFrom plotly plot_ly layout config
#' @export
pricing_pieces_plot <- function(df_prices){
  return(
    df_prices |>
      plot_ly(
        x = ~retail_price,
        y = ~pieces,
        type = "scatter",
        hovertemplate = paste(
          "<b>Prix</b> : %{x}",
          "<br><b>Nombre de pièces</b> : %{y}",
          "<extra></extra>"
        ),
        marker = list(
          color = "#DA291C",
          opacity = 0.85
        )
      ) |>
      layout(
        hoverlabel = list(
          bordercolor = "lightgrey", # Couleur de la bordure du tooltip
          font = list(family = "PT Sans", color = 'white')
        ),
        font = list(family = "PT Sans"),
        xaxis = list(
          title = "",
          zeroline = FALSE,
          ticksuffix= " €"
        ),
        yaxis = list(
          title = "",
          zeroline = FALSE,
          ticksuffix= "  "
        ),
        margin = list(l = 40, r = 40, b = 40, t = 40)
      ) |>
      config(displayModeBar = FALSE)
  )
}
