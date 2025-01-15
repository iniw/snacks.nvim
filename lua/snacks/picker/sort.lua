---@class snacks.picker.sorters
local M = {}

---@alias snacks.picker.sort.Field { name: string, desc: boolean }

---@class snacks.picker.sort.Config
---@field fields? (snacks.picker.sort.Field|string)[]

---@param opts? snacks.picker.sort.Config
function M.default(opts)
  local fields = {} ---@type snacks.picker.sort.Field[]
  for _, f in ipairs(opts and opts.fields or { { name = "score", desc = true }, "idx" }) do
    if type(f) == "string" then
      table.insert(fields, { name = f, desc = false })
    else
      table.insert(fields, f)
    end
  end

  ---@param a snacks.picker.Item
  ---@param b snacks.picker.Item
  return function(a, b)
    for _, field in ipairs(fields) do
      local av, bv = a[field.name], b[field.name]
      if (av ~= nil) and (bv ~= nil) and (av ~= bv) then
        if field.desc then
          return av > bv
        else
          return av < bv
        end
      end
    end
    return false
  end
end

function M.idx()
  ---@param a snacks.picker.Item
  ---@param b snacks.picker.Item
  return function(a, b)
    return a.idx < b.idx
  end
end

return M