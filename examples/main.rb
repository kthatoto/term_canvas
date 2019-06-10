require 'term_canvas'
require 'json'

Color = TermCanvas::Color
main_field = TermCanvas.new(x: 0, y: 0, w: 50, h: 30) # x, y, w, h
console = TermCanvas.new(x: 0, y: 30, w: 50, h: 10)
player = Player.new

loop do
  key = TermCanvas.gets
  `termworld post /key {"key":#{key}}` if !key.nil?

  data = JSON.parse(`termworld get /`)

  if data["updated"]
    main_field.clear
    player_abs_pos = {
      x: data["player"]["abs_pos"]["x"],
      y: data["player"]["abs_pos"]["y"]
    }
    player_rel_pos = {
      x: main_field.centerx - 1,
      y: main_field.centery
    }
    main_field.text(
      x: player_position[:x], y: player_position[:y],
      body: Player.direction(data["player"]["direction"]),
      background_color: Color::GREEN, text_color: Color::NORMAL
    )
    data["chips"].each_with_index do |chip_row, y|
      chip_row.each_with_index do |chip, x|
        chip_rel_pos = {
          x: player_abs_pos[:x] - player_rel_pos[:x] + x,
          y: player_rel_pos[:y] - player_rel_pos[:y] + y
        }
        if chip_rel_pos[:x] >= 0 && chip_rel_pos[:y] >= 0
          main_field.rect(
            x: chip_rep_pos[:x] * 2, y: chip_rep_pos[:y],
            width: 2, height: 1,
            background_color: Color::GROUND
          )
        end
      end
    end
    main_field.update
  end
end

puts 'exited'
