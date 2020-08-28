require 'set'
require './dice.rb'
require './hex.rb'
require './skills.rb'
require './game.rb'
require './units/unit.rb'


ranger_1 = MistwoodRanger.new("p1")
ranger_2 = MistwoodRanger.new("p2")


summon Lorsaan.new("p1"), :a1
summon ranger_1, :a3
summon ranger_1, :a3
summon ranger_1, :a3

summon Lorsaan.new("p2"), :b2
summon ranger_2, :a5
summon ranger_2, :a5
summon ranger_2, :b6


take_action :a1, :b2, "Snipe"
take_action :a1, :b2, "Mystic Arrow"
take_action :a1, :b2, "Piercing Shot"
take_action :a1, :b1, "Advance"
take_action :b1, :a3, "Field Instruction"
take_action :b6, :a5, "Advance"
