return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup {
                term_colors = true,
                transparent_background = false,
                styles = {
                    comments = {},
                    conditionals = {},
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                },
                color_overrides = {
                    mocha = {
                        base = "#000000",
                        mantle = "#000000",
                        crust = "#000000",
                        text = "#ffffff",
                    },
                },
                itegrations = {
                    telescope = {
                        enable = true,
                        style = "nvchad",
                    },
                    dropbar = {
                        enable = true,
                        color_mode = true,
                    },
                },
            }
            vim.cmd.colorscheme "catppuccin"
        end,
    },
}
