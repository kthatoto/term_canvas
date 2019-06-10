require 'term_canvas'

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
    Rect.new(
      x: 0, y: 0, width: 10, height: 10, background_color: {r: 200, b: 200, g: 800}
    )
  )
  field.text(
    Text.new(
      x: text_pos[:x], y: text_pos[:y], body: "test",
      background_color: {r: 800, g: 800, b: 800}, foreground_color: {r: 200, g: 200, b: 200}
    )
  )
  field.update
  sleep 0.05
end
TermCanvas.close
