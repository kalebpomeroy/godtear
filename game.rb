class Board
    def initialize
        @spaces = {}
        letters = [:a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l]
        (0..11).each do |row|

            letter = letters[row]
            (0..14).each do |column|
                x = column - (row - (row&1)) / 2
                y = (-1*x)-row
                z = row
                name = "#{letter}#{column+1}".to_sym
                @spaces[name]= Hex.new(name, x, y, z)
            end
        end
    end

    def describe
        @spaces.each do |name, hex|
            puts "#{name} #{hex} contains #{hex.contents.map{|c| "#{c.name} (#{c.player})"}}"
        end
    end

    def summon unit, to
        raise "Invalid Move" unless @spaces[to].can_enter? unit
        @spaces[to].enter(unit)
        unit.locations << to
    end

    def move from, to
        raise "No model found in #{from}" unless from.unit
        raise "Invalid Move" unless to.can_enter? from.unit

        to.enter from.unit
        from.leave
    end

    def [] k
        return @spaces[k]
    end

    def take_action source, target, action
        source_hex = @spaces[source]
        target_hex = @spaces[target]

        skill = source_hex.unit[action]
        source_hex.unit.action_counter
        skill.execute self, source_hex, target_hex
    end
end


$board = Board.new
def summon what, where
    $board.summon what, where
end
def take_action from, to, action
    $board.take_action from, to, action
end
