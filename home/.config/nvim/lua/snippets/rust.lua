local ls = require("luasnip")

local fmt = require("luasnip.extras.fmt").fmt

local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node

return {
  s(
    { trig = "mt", name = "insert mod test structure" },
    fmt(
      [[
      #[cfg(test)]
      mod tests {{
        {}
      }}
    ]],
      { i(0) }
    )
  ),

  s(
    { trig = "test", name = "insert new test" },
    fmt(
      [[
      #[test]
      fn {}() {{
        {}
      }}
    ]],
      { i(1, "your_awesome_test"), i(0) }
    )
  ),

  s(
    { trig = "tc", name = "insert new test using the test_case crate" },
    fmt(
      [[
      #[test_case({})]
      fn {}({}) {{
        {}
      }}
    ]],
      { i(2), i(1, "your_awesome_test"), i(3, "your_parameter"), i(0) }
    )
  ),

  s(
    { trig = "pd", name = "insert debug println!" },
    fmt(
      [[
      println!("{{:?}}", {});
    ]],
      { i(0) }
    )
  ),
}
