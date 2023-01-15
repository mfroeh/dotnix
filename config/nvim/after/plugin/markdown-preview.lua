-- set to 1, nvim will open the preview window after entering the markdown buffer default: 0
-- Doesn't work for me :(
vim.g.mkdp_auto_start = 1

-- set to 1, the nvim will auto close current preview window when change
-- from markdown buffer to another buffer
-- default. 1
vim.g.mkdp_auto_close = 1

-- set to 1, the vim will refresh markdown when save the buffer or
-- leave from insert mode, default 0 is auto refresh markdown as you edit or
-- move the cursor
-- default. 0
vim.g.mkdp_refresh_slow = 0

-- preview page title
-- ${name} will be replace with the file name
vim.g.mkdp_page_title = "「${name}」"

-- set default theme (dark or light)
-- By default the theme is define according to the preferences of the system
vim.g.mkdp_theme = "dark"
