au filetype python :iabbrev pudb import pudb;pudb.set_trace()

" https://vim.fandom.com/wiki/Syntax_folding_of_Python_files#:~:text=The%20default%20files%20provided%20with,be%20all%20that%20is%20needed.
" this is still pretty slow with >1k lines files
"setlocal foldmethod=indent
"setlocal foldlevelstart=1
"setlocal foldnestmax=2
"setlocal foldlevel=1

" Allows use of `gf` in python files only when in a venv
python << EOF
import os
import sys
import vim
from glob import glob


def clean_for_path(text):
    return text.replace(" ", r"\ ")

# Virtualenv
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    site_packages = glob(os.path.join(project_base_dir, 'lib/*/site-packages'))[0]
    std_lib = os.path.dirname(site_packages)
    for path in [std_lib, site_packages]:
        if not os.path.isdir(path):
            continue
        vim.command(r"set path+=%s" % clean_for_path(path))

#./base <= Vim
#./base/odoo
#./base/enterprise
if 'ODOO_WORKSPACE' in os.environ:
    vim.command(r"set path+=odoo")
EOF
