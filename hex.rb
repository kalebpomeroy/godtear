class Hex
    attr_accessor :name, :contents, :objective, :x, :y, :z

    def initialize name, x, y, z
        @x = x
        @y = y
        @z = z
        @name = name
        @objective = false
        @contents = []
    end

    def can_enter? model
        # Is it ever a legal space?
        return false if @objective and !model.can_be_on_objective

        # Is it empty?
        return true if @contents.length == 0

        # If it's not empty, large models can't be there
        return false if model.size == :large

        # If they aren't the same model they can't move in there
        return false unless @contents.first.name == model.name

        # And they have to be owned by the same player
        return false unless @contents.first.player == model.player

        # They share a name, but will they fit?
        return (@contents.length < 3)
    end

    def enter model
        model.locations << self
        @contents << model
    end

    def leave
        unit.locations.delete_at(unit.locations.index self)
        @contents.pop()
    end

    def - h
        ((@x - h.x).abs + (@y - h.y).abs + (@z - h.z).abs) / 2
    end

    def unit
        return @contents.first
    end

    def to_s
        "(#{@x}, #{@y}, #{@z})"
    end
end
