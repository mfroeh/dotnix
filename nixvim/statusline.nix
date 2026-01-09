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

    local function getLastBuffers(n)
      local buffers = vim.fn.getbufinfo({ buflisted = 1 })
      table.sort(buffers, function (a, b) return a.lastused > b.lastused end)

      local visibleWindows = vim.api.nvim_list_wins()
      local visibleBuffers = {}
      for _, win in ipairs(visibleWindows) do
        table.insert(visibleBuffers, vim.api.nvim_win_get_buf(win))
      end

      local firstBuffers = {}
      for _, buf in ipairs(buffers) do
        if not vim.tbl_contains(visibleBuffers, buf.bufnr) then
          table.insert(firstBuffers, buf)
        end
        if #firstBuffers == n then
          break
        end
      end

      return firstBuffers
    end

    local function formatBuffers(buffers, from, to)
      local hlGroups = {
        "DiagnosticError",
        "DiagnosticWarn",
        "DiagnosticInfo",
        "DiagnosticHint"
      }

      local bufferNames = {}
      for i = from, math.min(#buffers, to) do
          local name = vim.fn.fnamemodify(buffers[i].name, ":t")
          table.insert(bufferNames, string.format("%s %%#%s#[%d]%%*", name, hlGroups[i], i))
      end
      return table.concat(bufferNames, " ")
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

      local diags = {}
      if errors > 0 then
        table.insert(diags, string.format("%%#DiagnosticError#%d", errors))
      end
      if warnings > 0 then
        table.insert(diags, string.format("%%#DiagnosticWarn#%d", warnings))
      end
      if infos > 0 then
        table.insert(diags,  string.format("%%#DiagnosticInfo#%d", infos))
      end
      if hints > 0 then
        table.insert(diags,  string.format("%%#DiagnosticHint#%d", hints))
      end

      local diagStr = table.concat(diags, " ")
      local left = getMode() .. sep .. diagStr
      local leftWidth = displayStrLen(left)

      local lastBuffers = getLastBuffers(4)
      local center = formatBuffers(lastBuffers, 1, 2) .. "    " .. vim.fn.expand("%f") .. get_current_function() .. "    " .. formatBuffers(lastBuffers, 3, 4)
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

    local function openRecent(n)
      local buf = getLastBuffers(n)[n]
      if buf and buf.bufnr then
        vim.api.nvim_win_set_buf(0, buf.bufnr)
      end
    end
    vim.keymap.set("n", "<M-1>", function() openRecent(1) end)
    vim.keymap.set("n", "<M-2>", function() openRecent(2) end)
    vim.keymap.set("n", "<M-3>", function() openRecent(3) end)
    vim.keymap.set("n", "<M-4>", function() openRecent(4) end)

    vim.opt.laststatus = 3
    vim.opt.statusline = "%!v:lua.GetStatusLine()"
  '';
}
