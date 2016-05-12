# Editing

Commands for navigating and editing files.

| Navigation | |
|---|---|
| Page down | C-d |
| Page up | C-u |
| Move by paragraph | { and } |
| Move by word | w |
| Jump to char \* | f\* |
| Jump to before char \* | t\* |
| Move cursor | h j k l |
| Beginning/end of line | ^ / $ |

| Editing | |
|---|---|
| Enter insert mode | i |
| Enter visual mode (text select) | v |
| V-mode Copy / Paste / Cut | y / p / d |
| Cut single char | x |
| Write changes | :w |
| Paste to command line | C-r |
| Copy / Cut current line | yy / dd |
| Undor / Redo | u / 
| Open [Gundo](http://sjl.bitbucket.org/gundo.vim/) (visualize undo tree) | leader-gu |
| New line below / above cursor | o / O |

| Files (using [NERDTree](https://github.com/scrooloose/nerdtree) | |
|---|---|
| Open menu | m |
| Add node | ma |
| Move node | mm |
| Delete note | md |
| Copy node | mc |

| Buffers, Splits, and Tabs | |
|---|---|
| Jump to buffer | leader-b |
| Save all open buffers | leader-s |
| Create vertical/horizontal split | leader-v/h |
| Switch between windows | C-w h j k l |
| Cycle between windows | C-w w |
| Close window | C-w c |
| Expand/restore window | C-w o |
| New tab | :tabe |
| Switch tabs next / last | gt / gT |
| Goto tab # | g# |
| (in NerdTree) Open node in tab and goto / stay | t / T |
| (in NerdTree) Open node in horizontal/vertical split | s / i |
| (in CtrlP) Open file in new tab | C-t |
| Save and close buffer/tab/split | zz |
