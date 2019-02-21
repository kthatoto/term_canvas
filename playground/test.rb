require 'term_canvas'

Color = TermCanvas::Color
field = TermCanvas.new(x: 0, y: 0, w: 50, h: 30)

text_pos = {y: 0, x: 0}
loop do
  key = TermCanvas.gets
  case key
  when ?k
    text_pos[:y] -= 1
  when ?j
    text_pos[:y] += 1
  when ?h
    text_pos[:x] -= 2
  when ?l
    text_pos[:x] += 2
  when ?q
    break
  end
  field.clear
  field.rect(
    x: 0, y: 0, width: field.width, height: field.height,
    background_color: Color::BLUE
  )
  field.text(
    x: text_pos[:x], y: text_pos[:y], body: "test",
    background_color: Color::RED, foreground_color: Color::BLUE
  )
  field.update
  sleep 0.01
end
TermCanvas.close_all
