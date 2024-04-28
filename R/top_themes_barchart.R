top_themes_barchart <- function(df_prices, themes){
  return(
    df_prices |>
      filter(theme %in% themes) |>
      group_by(theme) |>
      summarise(number_of_sets = n()) |>
      arrange(desc(number_of_sets)) |> 
      plot_ly(
        x = ~number_of_sets,
        y = ~theme,
        alpha = 0.85,
        type = "bar",
        marker = list(color = "#DA291C", opacity = 0.85),
        hovertemplate = paste(
          "<b>Thème</b> : %{y}",
          "<br><b>Nombre total de sets</b> : %{x}",
          "<extra></extra>"
        )
      ) |> 
      layout(
        yaxis = list(title = "", categoryorder = "total ascending", ticksuffix="  "),
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