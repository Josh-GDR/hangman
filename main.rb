require './lib/randomWordChooser.rb'

rwc = RandomWordChooser.new

for i in (0...10)
  rwc.startGame
end
