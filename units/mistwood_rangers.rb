class MistwoodRanger < Unit
    @@type = :follower
    @@size = :small
    def initialize player
        super
        @name = "Mistwood Rangers"
        @plot_speed = 2
        @clash_speed = 3
        @dodge = 3
        @armor = 1
        @health = 1
        @count = 3
        @passives = [:killshot]
        skill "Blur",
              phase: :plot,
              type: :self,
              hit_effect: Proc.new { |b,s,t| t.unit.boon(:dodge) }
        skill "Fairy Fire",
              phase: :plot,
              type: :enemy,
              range: 3,
              hit: [3, 4, 5],
              hit_effect: Proc.new { |b,s,t| t.unit.blight(:armor) }
        skill "Aim",
              phase: :clash,
              type: :self,
              hit_effect: Proc.new { |b,s,t| t.unit.boon(:acc) }
        skill "Fire",
              phase: :plot,
              type: :enemy,
              range: 3,
              hit: [3, 4, 5],
              damage: [3, 4, 5]
    end
end
