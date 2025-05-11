# Local Configuration (`local.lua`)

The `local.lua` file is an optional configuration file that allows users to provide their own plugins and an `after_load` function. This file is not included in the repository by default, as it is intended for user-specific customizations.

## Structure of `local.lua`

The `local.lua` file should return a table with the following structure:

```lua
return {
    plugins = {
        -- List of plugins to load
    },
    after_load = function()
        -- Code to execute after the configuration is loaded
    end,
}
```

## Example `local.lua`

Here is an example of how you can define your own `local.lua` file:

```lua
return {
    plugins = {
        { "tpope/vim-surround" },
        { "junegunn/fzf", run = function() vim.fn["fzf#install"]() end },
        { import = "plugins.local" },
    },
    after_load = function()
        print("Custom configuration loaded!")
    end,
}
```
