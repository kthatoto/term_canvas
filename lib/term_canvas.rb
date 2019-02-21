require 'curses'
require 'term_canvas/base_screen'
class TermCanvas
  VERSION = "0.1.0"

  attr_accessor :width, :height
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
    @texts = []
    @rects = []
  end

  def centerx
    @win.width / 2 + @win.width % 2
  end

  def centery
    @win.height / 2 + @win.height % 2
  end

  def text(x:, y:, body:, foreground_color:, background_color:)
    @texts << {
      x: x, y: y, body: body,
      background_color: background_color, foreground_color: foreground_color,
    }
  end

  def rect(x:, y:, width:, height:, background_color:)
    @rects << {
      x: x, y: y, width: width, height: height,
      background_color: background_color,
    }
  end

  def update
    draw
    @win.refresh
  end

  module Color
    include BaseScreen::Color
  end

  private
  def draw
    @rects.each do |rect|
      `echo #{pp rect} >> log.txt`
      color_pair = BaseScreen.instance.find_or_create_color_pair(
        background_color: rect[:background_color]
      )
      @win.setpos(rect[:y], rect[:x])
      @win.attron(color_pair[:id])
      @win.addstr(rect[:body])
      @win.attroff(color_pair[:id])
    end
    @texts.each do |text|
      color_pair = BaseScreen.instance.find_or_create_color_pair(
        foreground_color: text[:foreground_color],
        background_color: text[:background_color]
      )
      @win.setpos(text[:y], text[:x])
      @win.attron(color_pair[:id])
      @win.addstr(text[:body])
      @win.attroff(color_pair[:id])
    end
  end

  def close
    @win.close
  end
end
