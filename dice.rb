# This is the die roll thingy
DIE = [0, 0, 1, 1, 1, 2]
def roll dice
    results = []
    dice.times { results << DIE.sample }
    results.inject(0, :+)
end
