require "aerial".setup(
  {
    backends = {"treesitter", "lsp", "markdown"},
    close_behavior = "auto",
    default_direction = "prefer_left",
    disable_max_lines = 10000,
    disable_max_size = 10000000,
    filter_kind = {
      "Class",
      "Constructor",
      "Enum",
      "Function",
      "Interface",
      "Module",
      "Method",
      "Struct"
    },
    highlight_on_hover = true
  }
)