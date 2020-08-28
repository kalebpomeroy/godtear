class Lorsaan < Unit
    @@type = :champion
    @@size = :large

    def initialize player
        @type = :champion
        @name = "Lorsaan"
        @plot_speed = 2
        @clash_speed = 3
        @dodge = 4
        @armor = 1
        @count = 1
        @health = 6
        @passives = [
            :slayer,
            :shoot_and_scoot
        ]
        super
        skill "Field Instruction",
              phase: :plot,
              type: :friend,
              range: 2,
              hit_effect: Proc.new { |b,s,t| t.unit.boon(:damage) }
        skill "Fairy Fire",
              phase: :plot,
              type: :enemy,
              range: 3,
              hit: [5],
              hit_effect: Proc.new { |b,s,t| t.unit.blight(:armor) }
        skill "Piercing Shot",
            phase: :clash,
            type: :enemy,
            range: 3,
            hit: [5],
            hit_effect: Proc.new {|b,s,t| t.unit.wound }
        skill "Mystic Arrow",
            phase: :clash,
            type: :enemy,
            range: 3,
            hit: [3],
            damage: [5],
            hit_effect: Proc.new {|b,s,t| t.unit.damage(roll 5)}
        skill "Snipe",
            phase: :clash,
            type: :enemy,
            range: 3,
            hit: [8],
            damage: [4]
        skill "Deathblow",
            ultimate: true,
            phase: :all,
            type: :enemy,
            range: 3,
            hit: [6],
            hit_effect: Proc.new {|b,s,t| t.unit.wound 2}
    end
end
