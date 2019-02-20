require 'curses'
Curses.init_screen
Curses.stdscr.nodelay = 1
Curses::noecho
Curses.curs_set(0)
Curses.start_color
Curses.use_default_colors
Curses.init_color(34, 400, 0, 800)
Curses.init_pair(2, Curses::COLOR_RED, 34)
win = Curses::Window.new(10, 10, 0, 0)
color_key = 0
`echo #{pp Curses.color_pairs} >> log.txt`
loop do
  key = Curses.getch
  case key
  when ?j
    color_key += 1
  when ?k
    color_key -= 1
  when ?q
    break
  end
  win.setpos(3, 5)
  win.attron(Curses.color_pair(color_key))
  win.addstr("a")
  win.attroff(Curses.color_pair(color_key))
  win.refresh
end
Curses.close_screen
