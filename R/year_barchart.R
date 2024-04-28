year_barchart <- function(df_prices, years = 2014:2024){
  return(
    df_prices |>
      group_by(year) |>
      filter(year %in% years) |> 
      summarise(number_of_sets = n()) |>
      arrange(desc(year)) |> 
      plot_ly(
        x = ~as.factor(year),
        y = ~number_of_sets,
        alpha = 0.85,
        type = "bar",
        marker = list(color = "#DA291C", opacity = 0.85),
        hovertemplate = paste(
          "<b>Année</b> : %{x}",
          "<br><b>Nombre total de sets</b> : %{y}",
          "<extra></extra>"
        )
      ) |> 
      layout(
        yaxis = list(title = "", ticksuffix="  ", zeroline = FALSE),
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