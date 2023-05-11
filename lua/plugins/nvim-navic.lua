-- https://www.reddit.com/r/neovim/comments/vpxexc/pde_custom_winbar_and_statusline_without_plugins/
local M = {}

local isempty = function(s)
  return s == nil or s == ""
end

vim.cmd([[
  highlight WinBar           guifg=#BBBBBB gui=bold
  highlight WinBarLocation   guifg=#888888 gui=bold
  highlight WinBarModified   guifg=#d7d787 gui=bold
  highlight WinBarGitDirty   guifg=#d7afd7 gui=bold
  highlight WinBarIndicator  guifg=#5fafd7 gui=bold
]])

local winbar_filetype_exclude = {
  [""] = true,
  ["NvimTree"] = true,
  ["Outline"] = true,
  ["Trouble"] = true,
  ["alpha"] = true,
  ["dashboard"] = true,
  ["lir"] = true,
  ["neo-tree"] = true,
  ["neogitstatus"] = true,
  ["packer"] = true,
  ["spectre_panel"] = true,
  ["startify"] = true,
  ["toggleterm"] = true,
}

M.get_neo_tree_context = function()
  local context = require("neo-tree.ui.selector").get_scrolled_off_node_text()
  if isempty(context) then
    return M.active_indicator()
  else
    return context
  end
end

M.get_winbar = function()
  -- floating window
  local cfg = vim.api.nvim_win_get_config(0)
  if cfg.relative > "" or cfg.external then
    return ""
  end

  if vim.bo.filetype == "neo-tree" then
    return "%{%v:lua.status.get_neo_tree_context()%}"
  end

  if winbar_filetype_exclude[vim.bo.filetype] then
    return "%{%v:lua.status.active_indicator()%}"
  end

  if vim.bo.buftype == "terminal" then
    return "%{%v:lua.status.get_icon()%} TERMINAL #%n %#WinBarLocation# %{b:term_title}%*"
  else
    local buftype = vim.bo.buftype
    -- real files do not have buftypes
    if isempty(buftype) then
      return table.concat({
        "%{%v:lua.status.get_filename()%}",
        "%<",
        "%{%v:lua.status.get_location()%}",
        "%=",
        "%{%v:lua.status.get_diag()%}",
        "%{%v:lua.status.get_git_dirty()%}",
      })
    else
      -- Meant for quickfix, help, etc
      return "%( %h%) %f"
    end
  end
end

local is_current = function()
  local winid = vim.g.actual_curwin
  if isempty(winid) then
    return false
  else
    return winid == tostring(vim.api.nvim_get_current_win())
  end
end

M.active_indicator = function()
  if is_current() then
    return "%#WinBarIndicator#▔▔▔▔▔▔▔▔%*"
  else
    return ""
  end
end
local icon_cache = {}

M.get_icon = function(filename, extension)
  if not filename then
    if vim.bo.modified then
      return " %#WinBarModified# %*"
    end

    if vim.bo.filetype == "terminal" then
      filename = "terminal"
      extension = "terminal"
    else
      filename = vim.fn.expand("%:t")
    end
  end

  local cached = icon_cache[filename]
  if not cached then
    if not extension then
      extension = vim.fn.fnamemodify(filename, ":e")
    end
    local file_icon, hl_group = require("nvim-web-devicons").get_icon(filename, extension)
    cached = " " .. "%#" .. hl_group .. "#" .. file_icon .. " %*"
    icon_cache[filename] = cached
  end
  return cached
end

M.get_filename = function()
  local has_icon, icon = pcall(M.get_icon)
  if has_icon then
    return icon .. "%t"
  else
    return " %t"
  end
end

local make_two_char = function(symbol)
  if symbol:len() == 1 then
    return symbol .. " "
  else
    return symbol
  end
end

local sign_cache = {}
local get_sign = function(severity, icon_only)
  if icon_only then
    local defined = vim.fn.sign_getdefined("DiagnosticSign" .. severity)
    if defined and defined[1] then
      return " " .. defined[1].text
    else
      return " " .. severity[1]
    end
  end

  local cached = sign_cache[severity]
  if cached then
    return cached
  end

  local defined = vim.fn.sign_getdefined("DiagnosticSign" .. severity)
  local text, highlight
  defined = defined and defined[1]
  if defined and defined.text and defined.texthl then
    text = " " .. make_two_char(defined.text)
    highlight = defined.texthl
  else
    text = " " .. severity:sub(1, 1)
    highlight = "Diagnostic" .. severity
  end
  cached = "%#" .. highlight .. "#" .. text .. "%*"
  sign_cache[severity] = cached
  return cached
end

M.get_diag = function()
  local d = vim.diagnostic.get(0)
  if #d == 0 then
    return ""
  end

  local min_severity = 100
  for _, diag in ipairs(d) do
    if diag.severity < min_severity then
      min_severity = diag.severity
    end
  end
  local severity = ""
  if min_severity == vim.diagnostic.severity.ERROR then
    severity = "Error"
  elseif min_severity == vim.diagnostic.severity.WARN then
    severity = "Warn"
  elseif min_severity == vim.diagnostic.severity.INFO then
    severity = "Info"
  elseif min_severity == vim.diagnostic.severity.HINT then
    severity = "Hint"
  else
    return ""
  end

  return get_sign(severity)
end

M.get_git_dirty = function()
  local dirty = vim.b.gitsigns_status
  if isempty(dirty) then
    return " "
  else
    return "%#WinBarGitDirty# %*"
  end
end

M.get_location = function()
  local success, result = pcall(function()
    if not is_current() then
      return ""
    end
    local provider = require("nvim-navic")
    if not provider.is_available() then
      return ""
    end

    local location = provider.get_location({})
    if not isempty(location) and location ~= "error" then
      return "%#WinBarLocation#  " .. location .. "%*"
    else
      return ""
    end
  end)

  if not success then
    return ""
  end
  return result
end

_G.status = M
vim.o.winbar = "%{%v:lua.status.get_winbar()%}"

return M
