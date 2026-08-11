--- Enforces C filetype for ".c" and ".h" files.
--- C++/CPP should always use ".cpp" and ".hpp" extensions.

local ft = vim.bo.filetype
local file_ext = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":e")

local handle_c = function()
  --
  vim.bo.filetype = "c"
  vim.filetype.add({
    extension = {
      c = "c",
      h = "c",
    },
  })
end

local handle_cpp = function()
  --
  vim.bo.filetype = "cpp"
  vim.filetype.add({
    extension = {
      cpp = "cpp",
      hpp = "cpp",
    },
  })
end

if (file_ext == "c" or file_ext == "h") and ft ~= "c" then
  handle_c()
elseif (file_ext == "cpp" or file_ext == "hpp") and ft ~= "cpp" then
  handle_cpp()
end
