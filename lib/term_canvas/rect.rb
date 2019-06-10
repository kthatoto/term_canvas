class Rect::TermCanvas < Object::TermCanvas
  attr_reader :background_color

  # @param x [Integer] Horizontal position of the object.
  # @param y [Integer] Vertical position of the object.
  # @param background_color [Hash] :r Red element of color of background.
  # @param background_color [Hash] :g Green element of color of background.
  # @param background_color [Hash] :b Blue element of color of background.
  def initialize(x:, y:, width:, height:, background_color:)
    @x = x
    @y = y
    @width = width
    @height = height
    @background_color = background_color
  end

  def foreground_color
    nil
  end

  # @param win [Curses::Window] Window to draw
  def draw(win)
    color_pair_id = BaseScreen.instance.find_or_create_color_pair(
      background_color: @background_color,
    ).id
    color_pair = Curses.color_pair(color_pair_id)
    win.setpos(@y, @x)
    win.attron(color_pair)
    @height.times do
      win.addstr(" " * @width)
      win.setpos(win.cury + 1, win.curx)
    end
    win.attroff(color_pair)
  end
end
