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
    def offset(x:, y:)
      @x += x
      @y += y
      self
    end
  end
end
