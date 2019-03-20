require 'curses'
require 'term_canvas/base_screen'
class TermCanvas
  VERSION = "0.1.0"

  attr_accessor :width, :height
  # Create a convenient window.
  # @param x [Integer] Horizontal position of the window. From left to right.
  # @param y [Integer] Vertical position of the window. From top to bottom.
  # @param w [Integer] Width of the window.
  # @param h [Integer] Height of the window.
  def initialize(x:, y:, w:, h:)
    BaseScreen.instance
    @win = Curses::Window.new(h, w, y, x)
    @x = x
    @y = y
    @width = w
    @height = h
    @texts = []
    @rects = []
  end

  class << self
    # Get key input.
    # @return [String] Inputted key.
    # @return [nil]
    def gets
      Curses.getch
    end

    # Close all windows.
    def close_all
      ObjectSpace.each_object(self) { |tc| tc.close }
      BaseScreen.instance.close
    end
  end

  # Clear objects and remove from the window.
  def clear
    @win.clear
    @texts = []
    @rects = []
  end

  # @return [Integer] Horizontal center of the window.
  def centerx
    @win.width / 2 + @win.width % 2
  end

  # @return [Integer] Vertical center of the window.
  def centery
    @win.height / 2 + @win.height % 2
  end

  # Add text object to the window but not display.
  # @param x [Integer] Horizontal position of the object.
  # @param y [Integer] Vertical position of the object.
  # @param body [String] Text body.
  # @param foreground_color [Hash] :r Red element of color of text.
  # @param foreground_color [Hash] :g Green element of color of text.
  # @param foreground_color [Hash] :b Blue element of color of text.
  # @param background_color [Hash] :r Red element of color of background.
  # @param background_color [Hash] :g Green element of color of background.
  # @param background_color [Hash] :b Blue element of color of background.
  def text(x:, y:, body:, foreground_color:, background_color:)
    @texts << {
      x: x, y: y, body: body,
      background_color: background_color, foreground_color: foreground_color,
    }
  end

  # Add rect object to the window but not display.
  # @param x [Integer] Horizontal position of the object.
  # @param y [Integer] Vertical position of the object.
  # @param background_color [Hash] :r Red element of color of background.
  # @param background_color [Hash] :g Green element of color of background.
  # @param background_color [Hash] :b Blue element of color of background.
  def rect(x:, y:, width:, height:, background_color:)
    @rects << {
      x: x, y: y, width: width, height: height,
      background_color: background_color,
    }
  end

  # Display objects that are added into the instance.
  def update
    draw
    @win.refresh
  end

  def close
    @win.close
  end

  private
  def draw
    # @rects.each do |rect|
    #   color_pair = BaseScreen.instance.find_or_create_color_pair(
    #     background_color: rect[:background_color]
    #   )
    #   @win.setpos(rect[:y], rect[:x])
    #   @win.attron(color_pair[:id])
    #   @win.addstr()
    #   @win.attroff(color_pair[:id])
    # end
    @texts.each do |text|
      cp_id = BaseScreen.instance.find_or_create_color_pair(
        foreground_color: text[:foreground_color],
        background_color: text[:background_color]
      )[:id]
      color_pair = Curses.color_pair(cp_id)
      @win.setpos(text[:y], text[:x])
      @win.attron(color_pair)
      @win.addstr(text[:body])
      @win.attroff(color_pair)
    end
  end
end
