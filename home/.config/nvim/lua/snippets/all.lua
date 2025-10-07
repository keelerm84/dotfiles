local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node

local function append_initials(args, snip, user_arg_1)
  -- Check for custom marker tag first
  if vim.g.marker_tag ~= nil and vim.g.marker_tag ~= "" then
    return "(" .. vim.g.marker_tag .. ")"
  end

  -- Fall back to initials
  if vim.g.initials ~= nil then
    return "(" .. vim.g.initials .. ")"
  end

  return ""
end

local function todo_marker(trigger, marker)
  return s(trigger, {
    t(marker),
    f(append_initials, {}, {}),
    t(": "),
    i(0)
  })
end

return {
  todo_marker("q", "QUESTION"),
  todo_marker("t", "TODO"),
  todo_marker("f", "FIXME"),
  todo_marker("w", "WARN"),
  todo_marker("x", "XXX"),
  todo_marker("n", "NOTE"),
}
