require('lualine').setup {
  options = {
    icons_enable = true,
    theme = 'nightfox',
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
