module TermCanvas
  class Object
    attr_reader :index

    # @param index [Integer]
    def set_index(index)
      @object_index = index
    end

    # @param x [Integer] Offset of x
    # @param y [Integer] Offset of y
    # @return self
    def position_offset(x: nil, y: nil)
      @x += x if x
      @y += y if y
      self
    end

    # @param x [Integer] New x
    # @param y [Integer] New y
    # @return self
    def position_override(x: nil, y: nil)
      @x = x if x
      @y = y if y
      self
    end
  end
end
