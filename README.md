# NeoVim Setup


## For Windows :
- Put `/nvim` file in `AppData/Local/`
- Put " compile_flags.txt & .clang-format " in root folder where you have cpp files

## Install clangd
- Download LLVM for Windows: `https://github.com/llvm/llvm-project/releases`
  (Look for LLVM-{version}-win64.exe)
- Add LLVM to system PATH



## Setting Main Working Directory & Terminal

```vim
" cd C:\Users\ACER\Documents\nvim
cd main_working_directory_path

" for terminal
:let &shell='C:\Windows\System32\cmd.exe'

"Python Path
let g:python3_host_prog = 'C:/Users/ACER/AppData/Local/Programs/Python/Python311/python.EXE'
```

## Cpp Setup

#### Format Code

After Installing LLVM , we have clang-format for Code formatting

```sh 
clang-format --version
```

#### Snippets 

Paste your JSON format snippet in this file 
<BR/>
**`~\AppData\Local\nvim-data\plugged\friendly-snippets\snippets\cpp\cpp.json`**

