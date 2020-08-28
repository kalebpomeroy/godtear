class Model
    def initialize card
        @card = card
    end
end

class Unit
    attr_accessor :type, :name, :size, :dodge, :armor, :health, :passives,
                  :player, :boons, :blights, :wounds, :phase, :actions, :count,
                  :locations, :size
    def initialize player
        @locations = []
        @boons = Set[]
        @blights = Set[]
        @wounds = 0
        @phase = :plot
        @actions = 0
        @bonus = false
        @skills = {}
        @player = player
        skill "Advance",
              phase: :plot,
              type: :empty,
              range: :speed,
              hit_effect: Proc.new { |b,s,t| b.move(s, t) }
    end

    def boon type
        @boons << type unless @blights.delete? type
    end

    def blight type
        @blights << type unless @boons.delete? type
    end

    def wound x = 1
        return if @wounds == @health or x <= 0
        @wounds = [@wounds + x, @health].min
    end

    def damage x = 1
        puts "Roll to damage... #{x} vs #{@armor}"
        wound(x - @armor)
    end

    def hits? x
        puts "Roll to hit... #{x} vs #{@dodge}"
        x >= @dodge
    end

    def skills phase
        @skills.filter {|k, v| v.phase == phase || phase == :all}
    end

    def speed
        (@phase == :clash) ? @clash_speed : @plot_speed
    end

    def can_be_on_objective
        return @type==:champion
    end

    def flip
        @actions = 0
        @phase = (phase == :clash ? :plot : :clash)
    end

    def action_counter
        @actions += 1
        self.flip if @actions == (@bonus ? 3 : 2)
    end

    def skill name, args
        @skills[name] = Skill.new(name, args)
    end

    def [] name
        return @skills[name]
    end
end

require './units/lorsaan.rb'
require './units/mistwood_rangers.rb'
