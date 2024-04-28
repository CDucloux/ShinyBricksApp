custom_theme <- function() {
  return(
    bslib::bs_theme(
      version = 5,
      bg = "#FFFFFF",
      fg = "#000000",
      primary = "#DA291C",
      secondary = "#FFD700",
      base_font = bslib::font_google("PT Sans"),
      code_font = bslib::font_google("Fira Code"),
      heading_font = bslib::font_google("Kanit"),
    )
  )
}

