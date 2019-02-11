require 'curses'
require 'term_canvas/base_screen'
class TermCanvas
  VERSION = "0.1.0"
  def initialize
    BaseScreen.instance
  end

  def close
    BaseScreen.instance.close
  end
end
