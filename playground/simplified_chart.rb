require 'curses'
Curses.init_screen
Curses.stdscr.nodelay = 1
Curses::noecho
Curses.curs_set(0)
Curses.start_color
Curses.use_default_colors
255.times do |i|
  Curses.init_pair(i, 0, i)
end
win = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
loop do
  key = Curses.getch
  case key
  when ?q
    break
  end
  l = 30
  255.times do |i|
    win.setpos(i / l, (i % l) * 3)
    win.attron(Curses.color_pair(i))
    win.addstr(format("%3d", i))
    win.attroff(Curses.color_pair(i))
  end
  255.times do |i|
    win.setpos(i / l + 10, (i % l) * 3)
    win.attron(Curses.color_pair(i + 256))
    win.addstr(format("%3d", i))
    win.attroff(Curses.color_pair(i + 256))
  end
  win.refresh
  sleep 0.5
end
Curses.close_screen
