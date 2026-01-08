{ ... }:
{
  programs.nixvim.extraConfigLuaPost = ''
    local humanReadableMode = {
      ['n']      = 'NRM',
      ['v']      = 'VIS',
      ['V']      = 'V-L',
      ['\22']    = 'V-B',
      ['i']      = 'INS',
      ['R']      = 'REP',
      ['c']      = 'CMD',
      ['t']      = 'TER',
    }
    local function getMode()
      local modeChar = vim.fn.mode()
      local mode = humanReadableMode[modeChar] or modeChar
      return mode
    end

    local function cleanStr(str)
      -- % is the escape character in lua patterns
      local clean = string.gsub(str, "%%#.-#", "")
      clean = string.gsub(clean, "%%%*", "")
      clean = string.gsub(clean, "%%%%", "%%")
      return clean
    end

    local function displayStrLen(str)
      return #cleanStr(str)
    end

    local function get_current_function()
      local current_node = vim.treesitter.get_node()
      if not current_node then return "" end

      local expr = current_node
      while expr do
        -- Rust, Go, Haskell
        if (expr:type() == "function_item" or expr:type() == "function_declaration" or expr:type() == "function") and (expr:field("name")[1]) then
          break
        end
        expr = expr:parent()
      end

      if not expr then return "" end

      local functionName = expr:field("name")[1]
      return " :: " .. vim.treesitter.get_node_text(functionName, 0)
    end

    function GetStatusLine()
      local sep = " "

      local diagosticCount = vim.diagnostic.count(0)
      local errors = diagosticCount[vim.diagnostic.severity.ERROR] or 0
      local warnings = diagosticCount[vim.diagnostic.severity.WARN] or 0
      local infos = diagosticCount[vim.diagnostic.severity.INFO] or 0
      local hints = diagosticCount[vim.diagnostic.severity.HINT] or 0

      local diags = string.format(
        "%%#DiagnosticError#%d %%#DiagnosticWarn#%d %%#DiagnosticInfo#%d %%#DiagnosticHint#%d",
        errors, warnings, infos, hints
      )
      local left = getMode() .. sep .. diags
      local leftWidth = displayStrLen(left)

      local center = vim.fn.expand("%f") .. get_current_function()
      local centerWidth = displayStrLen(center)

      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local lspStr = vim.iter(clients)
        :map(function(client) return client.name end)
        :join(" ")
      local lspInfo = string.format("%s [%s]", vim.bo.filetype or "no ft", lspStr)
      local filePercentage = math.ceil(vim.api.nvim_win_get_cursor(0)[1] / (vim.api.nvim_buf_line_count(0) or 1) * 100)
      local right = lspInfo .. sep .. filePercentage .. "%%"
      local rightWidth = displayStrLen(right)

      local termWidth = vim.o.columns
      local termCenter = math.floor(termWidth / 2)
      local centerStart = termCenter - (math.floor(centerWidth / 2))

      local leftPadded = left .. string.rep(" ", centerStart - leftWidth)
      local rightPadded = string.rep(" ", termWidth - (displayStrLen(leftPadded) + centerWidth + rightWidth)) .. right

      return leftPadded .. "%*" .. center .. "%*" .. rightPadded
    end

    vim.opt.laststatus = 3
    vim.opt.statusline = "%!v:lua.GetStatusLine()"
  '';
}
