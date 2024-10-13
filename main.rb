require './lib/randomWordChooser.rb'

rwc = RandomWordChooser.new

loop do
  print "0. exit\n1. New game\n2. load game\n3. configuration\n> "
  ans = gets.chomp.to_i

  if ans == 0
    puts 'Thank\'s for playing'
    break
  elsif ans == 1
    rwc.startGame
    system 'clear'
  elsif ans == 2
    system 'clear'
    puts '-- It will read directly from the SaveStates directory --'
    print "\ninput the file name and extension: "
    rwc.loadGame(gets.chomp.to_s)
  elsif ans == 3
    
  end
end