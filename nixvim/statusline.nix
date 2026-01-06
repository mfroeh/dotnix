{ ... }:
{
  programs.nixvim.extraConfigLuaPost = ''
    function GetStatusLine()
      local diagosticCount = vim.diagnostic.count(0)
      local errors = diagosticCount[vim.diagnostic.severity.ERROR] or 0
      local warnings = diagosticCount[vim.diagnostic.severity.WARN] or 0
      local infos = (diagosticCount[vim.diagnostic.severity.INFO] or 0) + (diagosticCount[vim.diagnostic.severity.HINT] or 0)

      local diags = string.format("E:%d W:%d I:%d", errors, warnings, infos)
      local left = diags

      local center = vim.fn.expand("%f")

      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local lspStr = vim.iter(clients)
        :map(function(client) return client.name end)
        :join(" ")
      local right = string.format("%s with [%s]", vim.bo.buftype, lspStr)

      local termWidth = vim.o.columns
      local termCenter = math.floor(termWidth / 2)
      local centerStart = termCenter - (math.floor(#center / 2))

      local leftPadded = left .. string.rep(" ", centerStart - #left)
      local rightPadded = string.rep(" ", termWidth - (#leftPadded + #center + #right)) .. right

      return leftPadded .. center .. rightPadded
    end

    vim.opt.laststatus = 3
    vim.opt.statusline = "%!v:lua.GetStatusLine()"
  '';
}
