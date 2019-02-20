require 'curses'
require 'term_canvas/base_screen'
class TermCanvas
  VERSION = "0.1.0"

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
    def gets
      Curses.getch
    end

    def close_all
      ObjectSpace.each_object(self) { |tc| tc.close }
      BaseScreen.instance.close
    end
  end

  def clear
    @win.clear
  end

  def centerx
    @win.width / 2 + @win.width % 2
  end

  def centery
    @win.height / 2 + @win.height % 2
  end

  def text(x:, y:, body:, background_color:, text_color:)
    @texts << {
      x: x, y: y, body: body,
      background_color: background_color, text_color: text_color,
    }
  end

  def rect(x:, y:, width:, height:, background_color:)
    @rects << {
      x: x, y: y, width: width, height: height,
      background_color: background_color,
    }
  end

  def draw
  end

  module Color
    GREEN = [   0, 1000,    0]
    BLUE  = [   0,    0, 1000]
    RED   = [1000,    0,    0]
  end

  private
  def close
    @win.close
  end
end
