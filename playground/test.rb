require 'term_canvas'
require 'json'

Color = TermCanvas::Color
main_field = TermCanvas.new(x: 0, y: 0, w: 50, h: 30)

loop do
  key = TermCanvas.gets
  main_field.text(
    x: 10, y: 10, body: "test",
    background_color: Color::RED, foreground_color: Color::BLUE
  )
  main_field.draw
end
