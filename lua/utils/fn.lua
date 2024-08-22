local M = {}

M.ext = function(table, key, value)
  local tbl = table
  tbl[key] = value
  return tbl
end

M.wrap = function(func, ...)
  local args = {...}
  return function()
    func(unpack(args))
  end
end

return M
