local map = vim.keymap.set
local function compile_latex()
  local file = vim.fn.expand '%:p'
  if not file:match '%.tex$' then
    vim.notify('Not a .tex file!', vim.log.levels.WARN)
    return
  end
  vim.cmd 'write'
  local dir = vim.fn.expand '%:p:h'
  local tex_file = vim.fn.expand '%:t'
  vim.notify('Compiling LaTeX...', vim.log.levels.INFO)
  vim.fn.system("cd '" .. dir .. "' && pdflatex '" .. tex_file .. "'")
  vim.notify('LaTeX compiled', vim.log.levels.INFO)
end
local function compile_and_view()
  local file = vim.fn.expand '%:p'
  if not file:match '%.tex$' then
    vim.notify('Not a .tex file!', vim.log.levels.WARN)
    return
  end
  vim.cmd 'write'
  local dir = vim.fn.expand '%:p:h'
  local tex_file = vim.fn.expand '%:t'
  vim.notify('Compiling LaTeX...', vim.log.levels.INFO)
  local result = vim.fn.system("cd '" .. dir .. "' && xelatex '" .. tex_file .. "'")
  local pdf = file:gsub('%.tex$', '.pdf')
  if vim.fn.filereadable(pdf) == 1 then
    vim.fn.jobstart({ 'zathura', pdf }, { detach = true })
    vim.notify('Compiled and opened in Zathura', vim.log.levels.INFO)
  else
    vim.notify('Compilation failed - check :messages', vim.log.levels.ERROR)
    print(result)
  end
end
map('n', '<leader>lc', compile_latex, { desc = 'Compile LaTeX' })
map('n', '<A-p>', compile_and_view, { desc = 'Compile and view PDF' })
