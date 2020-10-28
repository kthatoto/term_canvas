require 'curses'
require 'term_canvas/base_screen'
require 'term_canvas/object'
require 'term_canvas/text'
require 'term_canvas/rect'

module TermCanvas
  # Get key input.
  # @return [String] Inputted key.
  # @return [nil]
  def self.gets
    Curses.getch
  end

  # Close.
  def self.close
    Curses.close_screen
  end

  # @return [Integer] Width of this screen.
  def self.width
    TermCanvas::BaseScreen.instance
    Curses.cols
  end

  # @return [Integer] Height of this screen.
  def self.height
    TermCanvas::BaseScreen.instance
    Curses.lines
  end

  # Update objects to physical screen.
  def self.update
    TermCanvas::BaseScreen.instance
    Curses.doupdate
  end

  class Canvas
    attr_accessor :width, :height
    # Create a convenient window.
    # @param x [Integer] Horizontal position of the window. From left to right.
    # @param y [Integer] Vertical position of the window. From top to bottom.
    # @param w [Integer] Width of the window.
    # @param h [Integer] Height of the window.
    def initialize(x:, y:, w:, h:)
      TermCanvas::BaseScreen.instance
      @win = Curses::Window.new(h, w, y, x)
      @x = x
      @y = y
      @width = w
      @height = h
      @objects = []
      @object_index = 0
    end

    # Clear objects and remove from the window.
    def clear
      @win.clear
      @objects = []
      @object_index = 0
    end

    # @return [Integer] Horizontal center of the window.
    def centerx
      @width / 2
    end

    # @return [Integer] Vertical center of the window.
    def centery
      @height / 2
    end

    # Add text object to the window but not display.
    # @param object [Text] Text instance
    def text(object)
      raise 'The argument must be Text' if !(TermCanvas::Text === object)
      object.set_index(@object_index)
      @objects << object
      @object_index += 1
    end

    # Add rect object to the window but not display.
    def rect(object)
      raise 'The argument must be Rect' if !(TermCanvas::Rect === object)
      object.set_index(@object_index)
      @objects << object
      @object_index += 1
    end

    # @param color [Hash]
    #   :r Red element of color of background.
    #   :g Green element of color of background.
    #   :b Blue element of color of background.
    def background(color)
      object = TermCanvas::Rect.new(
        x: 0, y: 0, width: @width - 1, height: @height,
        background_color: color,
      )
      object.set_index(@object_index)
      @objects << object
      @object_index += 1
    end

    # Update objects to the virtual screen.
    def update
      draw
      @win.noutrefresh
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
end
