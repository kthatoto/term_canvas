require 'curses'

Curses.init_screen
Curses::noecho
Curses.curs_set(0)
Curses.start_color
Curses.use_default_colors

win = Curses::Window.new(10, 10, 10, 10)
puts win.class.to_s
sleep 10

Curses.close_screen
