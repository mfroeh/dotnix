{ ... }:
{
  programs.nixvim.extraConfigLuaPost = ''
    local function cleanStr(str)
      -- % is the escape character in lua patterns
      local clean = string.gsub(str, "%%#.-#", "")
      clean = string.gsub(clean, "%%%*", "")
      clean = string.gsub(clean, "%%%%", "%%")
      return clean
    end

    local function displayStrLen(str)
      local clean = cleanStr(str)
      return vim.fn.strdisplaywidth(clean)
    end

    _G.LastBuffers = {}
    local function updateLastBuffers(n)
      local visibleWindows = vim.api.nvim_list_wins()
      local visibleBuffers = {}
      for _, win in ipairs(visibleWindows) do
        table.insert(visibleBuffers, vim.api.nvim_win_get_buf(win))
      end

      local buffers = vim.fn.getbufinfo({ buflisted = 1 })
      table.sort(buffers, function (a, b) return a.lastused > b.lastused end)

      local firstBuffers = {}
      for _, buf in ipairs(buffers) do
        if not vim.tbl_contains(visibleBuffers, buf.bufnr) and buf.name ~= "" then
          table.insert(firstBuffers, buf)
        end
        if #firstBuffers == n then
          break
        end
      end

      _G.LastBuffers = firstBuffers
    end
    local statuslineGroup = vim.api.nvim_create_augroup("Statusline", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufDelete", "BufWinEnter", "BufWinLeave" }, {
      group = statuslineGroup,
      callback =  function() updateLastBuffers(4) end,
    })
    vim.api.nvim_exec_autocmds("BufEnter", {})

    _G.CurrentFunction = ""
    local function updateCurrentFunction()
      local function getCurrentFunctionName()
        local current_node = vim.treesitter.get_node()
        if not current_node then return "" end

        local expr = current_node
        while expr do
          -- Rust, Go, Haskell
          if (expr:type() == "function_item" or expr:type() == "function_declaration" or expr:type() == "function") and (expr:field("stores")[1]) then
            break
          end
          expr = expr:parent()
        end

        if not expr then return "" end

        local functionName = expr:field("name")[1]
        return " :: " .. vim.treesitter.get_node_text(functionName, 0)
      end

      local curName = getCurrentFunctionName()
      if curName ~= _G.CurrentFunction then
        _G.CurrentFunction = curName
        vim.cmd("redrawstatus")
      end
    end
    vim.uv.new_timer():start(0, 100, vim.schedule_wrap(updateCurrentFunction))


    local sep = " "
    local function getLeft()
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
      local modeChar = vim.fn.mode()
      local mode = humanReadableMode[modeChar] or modeChar

      local bufferDiagnostics = vim.diagnostic.count(0)
      local errors = bufferDiagnostics[vim.diagnostic.severity.ERROR] or 0
      local warnings = bufferDiagnostics[vim.diagnostic.severity.WARN] or 0
      local infos = bufferDiagnostics[vim.diagnostic.severity.INFO] or 0
      local hints = bufferDiagnostics[vim.diagnostic.severity.HINT] or 0
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
      local left = mode .. sep .. diagStr
      return left
    end

    local function getCenter()
      local function formatBuffers(buffers, indices)
        local hlGroups = {
          "DiagnosticError",
          "DiagnosticWarn",
          "DiagnosticInfo",
          "DiagnosticHint"
        }

        local bufferNames = {}
        for _, i in ipairs(indices) do
          if i <= #buffers then
              local name = vim.fn.fnamemodify(buffers[i].name, ":t")
              table.insert(bufferNames, string.format("%s %%#%s#[%d]%%*", name, hlGroups[i], i))
            end
        end
        return table.concat(bufferNames, " ")
      end

      local center = "   " .. vim.fn.expand("%f") .. _G.CurrentFunction .. "   "
      local leftCenter = formatBuffers(_G.LastBuffers, {1, 2})
      local rightCenter = formatBuffers(_G.LastBuffers, {3, 4})
      return leftCenter, center, rightCenter
    end

    local function getRight()
      local function getBufferPosition()
        local firstLine = vim.fn.line('w0')
        local lastLine = vim.fn.line('w$')
        local totalLines = vim.api.nvim_buf_line_count(0)
        local topRel = (firstLine - 1) / totalLines
        local viewRel = (lastLine - firstLine + 1) / totalLines

        -- Due to rounding with the limited precision, there is always going to be a trade-off between accurately displaying the top/bot offset correctly and having a constant view size.
        -- In this case we are favoring a constant view size, an alternative is to compute midWidth as total - left (ceil) - right (ceil), which accurately depicts the top/bot offset.
        local totalWidth = math.floor(vim.o.columns / 10)
        local leftWidth = math.floor(totalWidth * topRel)
        local midWidth = math.max(1, math.ceil(totalWidth * viewRel))
        local rightWidth = totalWidth - midWidth - leftWidth

        local inactiveChar = "░"
        local activeChar = "█"
        local out = string.rep(inactiveChar, leftWidth) .. string.rep(activeChar, midWidth) .. string.rep(inactiveChar, rightWidth)
        return out
      end

      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local lspStr = vim.iter(clients)
        :map(function(client) return client.name end)
        :join(" ")
      local lspInfo = string.format("%s [%s]", vim.bo.filetype or "no ft", lspStr)
      local scroller = getBufferPosition()
      local right = lspInfo .. sep .. scroller
      return right
    end

    function GetStatusLine()
      local left = getLeft()

      local leftCenter, center, rightCenter = getCenter()

      local right = getRight()

      local termWidth = vim.o.columns
      local termCenter = math.floor(termWidth / 2)
      local centerStart = termCenter - (math.floor(displayStrLen(center) / 2))

      local leftPadded = left .. string.rep(" ", centerStart - displayStrLen(left) - displayStrLen(leftCenter))
      local rightPadded = string.rep(" ", termWidth - (displayStrLen(leftPadded) + displayStrLen(leftCenter .. center .. rightCenter) + displayStrLen(right))) .. right

      return leftPadded .. "%*" .. leftCenter .. center .. rightCenter .. "%*" .. rightPadded
    end
    vim.opt.laststatus = 3
    vim.opt.statusline = "%!v:lua.GetStatusLine()"

    local function openRecent(n)
      local buf = _G.LastBuffers[n]
      if buf and buf.bufnr then
        vim.api.nvim_win_set_buf(0, buf.bufnr)
      end
    end

    vim.keymap.set("n", "<M-1>", function() openRecent(1) end)
    vim.keymap.set("n", "<M-2>", function() openRecent(2) end)
    vim.keymap.set("n", "<M-3>", function() openRecent(3) end)
    vim.keymap.set("n", "<M-4>", function() openRecent(4) end)
  '';
}
