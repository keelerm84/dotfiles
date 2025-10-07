 vim.cmd[[
 " Stolen from FZF's repo since it isn't an exported function
 function! s:get_git_root()
   if exists('*fugitive#repo')
     try
       return fugitive#repo().tree()
     catch
     endtry
   endif
   let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
   return v:shell_error ? '' : root
 endfunction

 function! SmartFzfSearching()
     let root = s:get_git_root()
     if empty(root)
         Files
     else
         GFiles
     endif
 endfunction
]]

-- Function to set/clear custom marker tag for TODO snippets
function SetMarkerTag()
  local current_tag = vim.g.marker_tag or ""
  local prompt = "Enter marker tag"
  if current_tag ~= "" then
    prompt = prompt .. " (current: " .. current_tag .. ", empty to clear)"
  else
    prompt = prompt .. " (empty to use initials)"
  end

  require("snacks").input({
    prompt = prompt,
    default = current_tag,
  }, function(input)
    if input == nil then
      -- User cancelled
      return
    end

    if input == "" then
      -- Clear the marker tag, revert to initials
      vim.g.marker_tag = nil
      require("snacks").notify("Marker tag cleared")
    else
      -- Set the new marker tag
      vim.g.marker_tag = input
      require("snacks").notify("Marker tag set to: " .. input)
    end
  end)
end
