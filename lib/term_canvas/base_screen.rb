require 'singleton'
require 'curses'
class BaseScreen
  include Singleton
  def initialize
    Curses.init_screen
    Curses::noecho
    Curses.curs_set(0)
  end

  def close
    Curses.close_screen
  end
end
