require 'curses'
Curses.init_screen
Curses.stdscr.nodelay = 1
Curses::noecho
Curses.curs_set(0)
Curses.start_color
Curses.use_default_colors
# Curses.init_color(34, 333, 0, 1000)
# Curses.init_pair(2, Curses::COLOR_RED, 34)
# 30.times do |i|
#   Curses.init_pair(i, i, 1)
# end
# (300..310).to_a.each do |i|
#   Curses.init_pair(i, 5, 0)
# end
win = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
loop do
  key = Curses.getch
  case key
  when ?q
    break
  end
  win.refresh
  sleep 0.5
end
Curses.close_screen
