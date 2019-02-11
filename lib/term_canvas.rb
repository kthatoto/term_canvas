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
  end

  def << self
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

  def text
  end

  def rect
  end

  def update
  end

  private
  def close
    @win.close
  end
end
