require 'term_canvas'

field = TermCanvas::Canvas.new(x: 0, y: 0, w: TermCanvas.width, h: TermCanvas.height)

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
    TermCanvas::Rect.new(
      x: field.centerx, y: field.centery, width: 2, height: 1, background_color: {r: 200, b: 200, g: 800}
    ).offset(x: -TermCanvas.width / 2, y: 0)
  )
  field.text(
    TermCanvas::Text.new(
      x: text_pos[:x], y: text_pos[:y], body: "test",
      background_color: {r: 800, g: 800, b: 800}, foreground_color: {r: 200, g: 200, b: 200}
    )
  )
  field.update
  sleep 0.05
end
TermCanvas.close
