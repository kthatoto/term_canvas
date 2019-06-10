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
    @color_struct = Struct.new(:id, :r, :g, :b)
    @color_pair_struct = Struct.new(:id, :fc_id, :bc_id)
    @color_pairs = [@color_pair_struct.new(0, 1, 0)]
    @colors = [@color_struct.new(0, 0, 0, 0)]
    @color_id_offset = 16
  end

  # @param foreground_color [Hash]
  #   :r Red element of color of text.
  #   :g Green element of color of text.
  #   :b Blue element of color of text.
  # @param background_color [Hash]
  #   :r Red element of color of background.
  #   :g Green element of color of background.
  #   :b Blue element of color of background.
  def find_or_create_color_pair(foreground_color: nil, background_color:)
    response_color_pair = nil
    fc_id = find_or_create_color(
      @color_struct.new(*foreground_color.values_at(*@color_struct.members))
    ).id
    bc_id = find_or_create_color(
      @color_struct.new(*background_color.values_at(*@color_struct.members))
    ).id
    @color_pairs.each do |cp|
      if cp.fc_id == fc_id && cp.bc_id == bc_id
        response_color_pair = cp
        break
      end
    end
    return response_color_pair || create_color_pair(fc_id, bc_id)
  end

  private

    def find_or_create_color(color)
      return @colors.find { |c| c.id == 0 } if color.r.nil?
      response_color = nil
      @colors.each do |_color|
        if same_color?(color, _color)
          response_color = _color
          break
        end
      end
      return response_color || create_color(r: color.r, g: color.g, b: color.b)
    end

    def create_color(r:, g:, b:)
      new_color_id = @colors.count + @color_id_offset
      new_color = @color_struct.new(new_color_id, r, g, b)
      Curses.init_color(*new_color)
      @colors << new_color
      return new_color
    end

    def create_color_pair(fc_id, bc_id)
      new_color_pair_id = @color_pairs.count
      new_color_pair = @color_pair_struct.new(new_color_pair_id, fc_id, bc_id)
      Curses.init_pair(*new_color_pair)
      @color_pairs << new_color_pair
      return new_color_pair
    end

    def same_color?(color1, color2)
      return color1.r == color2.r && color1.g == color2.g && color1.b == color2.b
    end
end
