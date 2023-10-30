# Select a file location and jump to it

Use vis-menu to open a file at a specific line and column by selecting it from a list.
The list of files can be generated using a specific command. Currently `make` and `grep`
are implemented. The `grep` search is recursively through all non-binary files.

## Usage

In vis:

`:make` or `:grep <pattern>`

## Configuration

In visrc.lua:

```lua
plugin_vis_jumplist = require('plugins/vis-jumplist')

-- Path to the vis-menu executable (default: "vis-menu")
plugin_vis_jumplist.vis_menu_path = "vis-menu"

-- Arguments passed to vis-menu (default: "-l 10")
plugin_vis_jumplist.vis_menu_args = "-l 10"

-- Path to command to run for make (default: "make")
plugin_vis_jumplist.make_cmd = "make"

-- Path to command to run for grep (default: "grep")
plugin_vis_jumplist.grep_cmd = "grep"

-- Arguments passed to grep (default: "-HInrs")
plugin_vis_jumplist.grep_options = "-HInrs"

-- Display length of matching lines (default: 100)
plugin_vis_jumplist.grep_line_length = 100

-- Mapping configuration example (<Space>m)
vis.events.subscribe(vis.events.INIT, function()
    vis:map(vis.modes.NORMAL, " m", ":make<Enter>", "run make in current dir")
end)
```
