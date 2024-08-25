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

M.printTable = function( tbl , level, filteDefault)
  local msg = ""
  filteDefault = filteDefault or true --默认过滤关键字（DeleteMe, _class_type）
  level = level or 1
  local indent_str = ""
  for i = 1, level do
    indent_str = indent_str.."  "
  end

  print(indent_str .. "{")
  for k,v in pairs(tbl) do
    if filteDefault then
      if k ~= "_class_type" and k ~= "DeleteMe" then
        local item_str = string.format("%s%s = %s", indent_str .. " ",tostring(k), tostring(v))
        print(item_str)
        if type(v) == "table" then
          printTable(v, level + 1)
        end
      end
    else
      local item_str = string.format("%s%s = %s", indent_str .. " ",tostring(k), tostring(v))
      print(item_str)
      if type(v) == "table" then
        printTable(v, level + 1)
      end
    end
  end
  print(indent_str .. "}")
end

return M
