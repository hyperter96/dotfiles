local ok, telescope = pcall(require, "telescope")
if ok then
  telescope.load_extension("hoogle")
end
