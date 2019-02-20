require 'curses'
Curses.init_screen
Curses.use_default_colors
win = Curses::Window.new(10, 10, 5, 5)
win.box(?|, ?-)
win.setpos(0, 0)
win.addch("a")
win.addch("b")
win.setpos(9, 9)
win.addstr("c00")
win.refresh

sleep 100
Curses.close_screen
