require 'singleton'
require 'curses'
class BaseScreen
  include Singleton
  module Color
    WHITE = 0
    RED = 1
    GREEN = 2
    YELLOW = 3
    BLUE = 4
    SKYBLUE = 6
    BLACK = 8
    ORANGE = 11
  end

  def initialize
    Curses.init_screen
    Curses::noecho
    Curses.curs_set(0)
    Curses.stdscr.nodelay = 1
    Curses.start_color
    Curses.use_default_colors
    @color_pairs = [
      {id: 0, foreground_color: Color::WHITE, background_color: Color::BLACK}
    ]
  end

  def close
    Curses.close_screen
  end

  def find_or_create_color_pair(foreground_color: nil, background_color:)
    color_pair = nil
    @color_pairs.each do |cp|
      if cp[:foreground_color] == foreground_color && cp[:background_color] == background_color
        color_pair = cp
        break
      end
    end
    return color_pair if color_pair
    color_pair = create_color_pair(background_color, foreground_color)
    return color_pair
  end

  private
  def create_color_pair(background_color, foreground_color = nil)
    new_id = @color_pairs.count
    Curses.init_pair(new_id, foreground_color || 0, background_color)
    new_color_pair = {id: new_id, foreground_color: foreground_color, background_color: background_color}
    @color_pairs << new_color_pair
    return new_color_pair
  end
end
