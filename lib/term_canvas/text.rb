class Text < Object::TermCanvas
  attr_reader :foreground_color, :background_color

  # @param x [Integer] Horizontal position of the object.
  # @param y [Integer] Vertical position of the object.
  # @param body [String] Text body.
  # @param foreground_color [Hash]
  #   :r Red element of color of text.
  #   :g Green element of color of text.
  #   :b Blue element of color of text.
  # @param background_color [Hash]
  #   :r Red element of color of background.
  #   :g Green element of color of background.
  #   :b Blue element of color of background.
  def initialize(x:, y:, body:, foreground_color:, background_color:)
    @x = x
    @y = y
    @body = body
    @foreground_color = foreground_color
    @background_color = background_color
  end

  # @param win [Curses::Window] Window to draw
  def draw(win)
    color_pair_id = BaseScreen.instance.find_or_create_color_pair(
      foreground_color: @foreground_color,
      background_color: @background_color,
    ).id
    color_pair = Curses.color_pair(color_pair_id)
    win.setpos(@y, @x)
    win.attron(color_pair)
    win.addstr(@body)
    win.attroff(color_pair)
  end
end
