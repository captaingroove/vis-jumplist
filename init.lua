--- Copyright (C) 2023  Jörg Bakker
---

local module = {}
module.vis_menu_path = "vis-menu"
module.vis_menu_args = "-l 20"
module.make_cmd = "make"
module.grep_cmd = "grep"
module.grep_options = "-HInrs"
module.grep_line_length = 100


vis:command_register("make", function(argv, force, win, selection, range)
	local cmd = module.make_cmd .. " 2>&1 >/dev/null | " .. module.vis_menu_path .. " " .. module.vis_menu_args
	local status, output, stderr = vis:pipe(win.file, {start = 0, finish = 0}, cmd)
	if status ~= 0 then return false end
	local file, line, col, msg = string.match(output, "^(.*):(%d+):(%d+):(.*)$")
	if file == nil then return true end
	vis:command("e '" .. file .. "'")
	if line == nil then return true end
	vis:command(line)
	if col == nil then return true end
	vis:feedkeys(string.format("%dl", tonumber(col) - 1))
	if msg == nil then return true end
	vis:info(msg:sub(1, -2))
	return true;
end)

vis:command_register("grep", function(argv, force, win, selection, range)
	local cmd = string.format("%s %s %s | tr '\t' '    ' | cut -b-%d | %s %s", 
		module.grep_cmd,
		module.grep_options,
		table.concat(argv, " "),
		module.grep_line_length,
		module.vis_menu_path,
		module.vis_menu_args)
	local status, output, stderr = vis:pipe(win.file, {start = 0, finish = 0}, cmd)
	if status ~= 0 then return false end
	local file, line = string.match(output, "^(.*):(%d+):.*$")
	if file == nil then return true end
	vis:command("e '" .. file .. "'")
	if line == nil then return true end
	vis:command(line)
	return true;
end)

return module