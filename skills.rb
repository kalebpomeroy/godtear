class Skill
    attr_accessor :name, :range, :attack, :damage, :type, :phase

    def initialize name, args
        @name = name
        args.each {|k,v| instance_variable_set("@#{k}", v)}
    end

    def execute board, source, target
        puts "#{source.unit.name} is targeting #{target} with #{@name} (range #{@range})"
        raise "Invalid action" if not can_be_done?(source, target)

        return false unless roll_to_hit(source, target)

        @hit_effect.call(board, source, target) if @hit_effect

        roll_for_damage(source, target) if @damage
    end

    def roll_to_hit source, target
        if @type == :enemy
            hit_roll = roll @hit[(source.contents.length) -1]
            return false unless target.unit.hits? hit_roll
        end
        return true
    end

    def roll_for_damage source, target
        dmg_roll = roll @damage[(source.contents.length) -1]
        target.unit.damage(dmg_roll)
    end

    def can_be_done? source, target
        return false if @range and not in_range?(source, target)
        return false if not valid_target?(source, target)
        true
    end

    def in_range? source, target
        range = (@range.is_a? Symbol) ? source.unit.send(@range) : @range
        (source - target) <= range
    end

    def valid_target? source, target
        case @type
        when :self
            return false if source.unit != target.unit
        when :enemy
            return false if source.unit.player == target.unit.player
        when :friend
            return false if source.unit.player != target.unit.player
        when :move
            return false if target.can_enter? source.unit
        end
        return true
    end
end
