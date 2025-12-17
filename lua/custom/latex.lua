-- ~/.config/nvim/lua/custom/latex.lua

local map = vim.keymap.set

-- Compile LaTeX document
local function compile_latex()
  local file = vim.fn.expand("%:p")

  if not file:match("%.tex$") then
    vim.notify("Not a .tex file!", vim.log.levels.WARN)
    return
  end

  vim.cmd("write")  -- Save first

  -- Compile in the file's directory (so it finds Resume.cls)
  local dir = vim.fn.expand("%:p:h")
  local tex_file = vim.fn.expand("%:t")

  vim.notify("Compiling LaTeX...", vim.log.levels.INFO)
  vim.fn.system("cd '" .. dir .. "' && pdflatex '" .. tex_file .. "'")

  vim.notify("LaTeX compiled", vim.log.levels.INFO)
end

-- Compile and open in Zathura
local function compile_and_view()
  local file = vim.fn.expand("%:p")

  if not file:match("%.tex$") then
    vim.notify("Not a .tex file!", vim.log.levels.WARN)
    return
  end

  vim.cmd("write")

  -- Compile in the file's directory
  local dir = vim.fn.expand("%:p:h")
  local tex_file = vim.fn.expand("%:t")

  vim.notify("Compiling LaTeX...", vim.log.levels.INFO)
  local result = vim.fn.system("cd '" .. dir .. "' && xelatex '" .. tex_file .. "'")

  -- Check if PDF was created
  local pdf = file:gsub("%.tex$", ".pdf")
  if vim.fn.filereadable(pdf) == 1 then
    vim.fn.jobstart({"zathura", pdf}, {detach = true})
    vim.notify("Compiled and opened in Zathura", vim.log.levels.INFO)
  else
    vim.notify("Compilation failed - check :messages", vim.log.levels.ERROR)
    print(result)  -- Show error output
  end
end

-- Keymaps for LaTeX/Zathura
map('n', '<leader>lc', compile_latex, { noremap = true, silent = true, desc = "Compile LaTeX" })
map('n', '<A-p>', compile_and_view, { noremap = true, silent = true, desc = "Compile and view PDF" })

