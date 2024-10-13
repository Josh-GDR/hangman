require './lib/randomWordChooser.rb'
require './lib/saveFiles.rb'

rwc = RandomWordChooser.new

def changeSerializer(serializerOpt = 0)
  if serializerOpt == 1
    serializer = SaveFiles.getCorrectDeserializer('.yaml')
    SaveFiles.serializer = serializer
    puts 'All save files will know be save with \'YAML\''
    return
  elsif serializerOpt == 2
    serializer = SaveFiles.getCorrectDeserializer('.json')
    SaveFiles.serializer = serializer
    puts 'All save files will know be save with \'JSON\''
    return
  end
  puts 'Please input a valid option between [1-2]'
end

loop do
  print "0. exit\n1. New game\n2. load game\n3. choose save format\n> "
  ans = gets.chomp.to_i

  system 'clear'
  if ans == 0
    puts 'Thank\'s for playing'
    break
  elsif ans == 1
    rwc.startGame
  elsif ans == 2
    puts '-- It will read directly from the SaveStates directory --'
    print "\ninput the file name and extension: "
    rwc.loadGame(gets.chomp.to_s)
  elsif ans == 3
    puts '|--  SELECT THE FORMAT IN WHICH YOU WANT TO SAVE YOUR GAMES --|'    
    print "\n1. yaml\n2. json\n> "
    changeSerializer(gets.chomp.to_i)
  end
end