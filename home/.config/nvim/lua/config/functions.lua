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
