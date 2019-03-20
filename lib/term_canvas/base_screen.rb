require 'singleton'
require 'curses'
class BaseScreen
  include Singleton

  def initialize
    Curses.init_screen
    Curses::noecho
    Curses.curs_set(0)
    Curses.stdscr.nodelay = 1
    Curses.start_color
    Curses.use_default_colors
    @color_pairs = [{id: 0, fc_id: 1, bc_id: 0}]
    @colors = [{id: 0, r: 0, g: 0, b: 0}, {id: 1, r: 1000, g: 1000, b: 1000}]
    @colors.each do |color|
      Curses.init_color(color[:id], color[:r], color[:g], color[:b])
    end
  end

  def close
    Curses.close_screen
  end

  def find_or_create_color_pair(foreground_color: nil, background_color:)
    response_color_pair = nil
    fc_id = find_or_create_color(foreground_color)[:id]
    bc_id = find_or_create_color(background_color)[:id]
    @color_pairs.each do |cp|
      if cp[:fc_id] == fc_id && cp[:bc_id] == bc_id
        response_color_pair = cp
        break
      end
    end
    return response_color_pair || create_color_pair(fc_id, bc_id)
  end

  private
  def find_or_create_color(color)
    return @colors.find { |c| c[:id] == 0 } if color.nil?
    response_color = nil
    @colors.each do |c|
      if c[:r] == color[:r] && c[:g] == color[:g] && c[:b] == color[:b]
        response_color = c
        break
      end
    end
    return response_color || create_color(r: r, g: g, b: b)
  end

  def create_color(r:, g:, b:)
    new_color_id = @colors.count
    Curses.init_color(new_color_id, r, g, b)
    new_color = {id: new_color_id, r: r, g: g, b: b}
    @colors << new_color
    return new_color
  end

  def create_color_pair(fc_id, bc_id)
    new_color_pair_id = @color_pairs.count
    Curses.init_pair(new_color_pair_id, fc_id, bc_id)
    new_color_pair = {
      id: new_color_pair_id,
      fc_id: fc_id,
      bc_id: bc_id
    }
    @color_pairs << new_color_pair
    return new_color_pair
  end
end
