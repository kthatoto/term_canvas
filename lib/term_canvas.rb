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
    @objects = []
    @object_index = 0
  end

  class << self
    # Get key input.
    # @return [String] Inputted key.
    # @return [nil]
    def gets
      Curses.getch
    end

    # Close.
    def close
      Curses.close_screen
    end
  end

  # Clear objects and remove from the window.
  def clear
    @win.clear
    @objects = []
    @object_index = 0
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
  # @param object [Text] Text instance
  def text(object)
    raise 'The argument must be Text::TermCanvas' if !(Text::TermCanvas === object)
    object.set_index(@object_index)
    @objects << object
    @object_index += 1
  end

  # Add rect object to the window but not display.
  def rect(object)
    raise 'The argument must be Rect::TermCanvas' if !(Rect::TermCanvas === object)
    object.set_index(@object_index)
    @objects << object
    @object_index += 1
  end

  # Display objects that are added into this instance.
  def update
    draw
    @win.refresh
  end

  def close
    @win.close
  end

  private

    def draw
      @objects.each do |object|
        object.draw(@win)
      end
    end
end
