require 'curses'

Curses.init_screen
Curses::noecho
Curses.curs_set(0)
Curses.start_color
Curses.use_default_colors

win = Curses::Window.new(10, 10, 10, 10)

color_struct = Struct.new(:id, :r, :g, :b)
id = 1
color = color_struct.new(id, 300, 900, 300)
Curses.init_color(*color)
Curses.init_pair(id, 0, id)
pair = Curses.color_pair(id)
win.attron(pair)
win.addstr("123")
win.attroff(pair)
win.refresh
sleep 3

Curses.close_screen
