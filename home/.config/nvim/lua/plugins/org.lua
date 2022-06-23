-----------------------------------------------------------
-- Orgmode configuration file
----------------------------------------------------------

-- Plugin: orgmode
-- url: https://github.com/nvim-orgmode/orgmode

local orgmode_status_ok, orgmode = pcall(require, 'orgmode')
if not orgmode_status_ok then
  return
end

orgmode.setup({
    org_agenda_files = {'~/Documents/Dropbox/OrgFiles/**/*'},
    org_default_notes_file = '~/Documents/Dropbox/OrgFiles/refile.org',
})
