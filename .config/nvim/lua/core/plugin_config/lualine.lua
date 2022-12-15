require('lualine').setup {
  options = {
    icons_enable = true,
    theme = 'nightfly',
  },
  sections = {
    lualine_a = {
      {
        'filename',
	path = 1,
      }
    }
  }
}
