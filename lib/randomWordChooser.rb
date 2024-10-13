require_relative 'saveFiles.rb'

class RandomWordChooser
  @@Dictionary = File.read('./lib/english_words.txt').lines
  @@maxTurns = 13

  def initialize
    restartFields
  end

  private def restartFields
    @incompleteWord = nil
    @selectedWord = ''
    @fileName = nil
    @wordPos = 0
  end

  def startGame
    restartFields
    chooserWord
    gameLoop
  end

  def correctFormat(word, serializer)
    if serializer == YAML
      return word.to_sym
    elsif serializer == JSON
      return word.to_s
    end
  end

  def loadGame(fileName)
    begin
      serializer = SaveFiles.getCorrectDeserializer(fileName.chars.drop(fileName.chars.index('.')).join)
      lastGame = SaveFiles.load(fileName)
      @incompleteWord = lastGame[correctFormat('word', serializer)]
      @wordPos = lastGame[correctFormat('pos', serializer)]
      @selectedWord = @@Dictionary[@wordPos]
      @fileName = fileName
      gameLoop(lastGame[correctFormat('turn', serializer)])   
    rescue
      puts 'There was an issue loading the save file, make sure you write it well'
    end
  end

  private def chooserWord
    @wordPos = Random.rand(@@Dictionary.length)
    @selectedWord = @@Dictionary[@wordPos]
    return chooserWord unless @selectedWord.length.between?(6,13)
    @incompleteWord = @incompleteWord.to_s.rjust(@selectedWord.length, '_')[0...@selectedWord.length]
  end

  private def gameLoop(turn = 0)
    loop do
      puts "#{@incompleteWord}"
      print "\nTurn #{turn}, maximum turns: #{@@maxTurns}\n1. Save game\n2. guess word\n> "
      ans = gets.to_i
      
      if ans == 1
        saveFile(turn)
        break
      elsif ans == 2
        print "\n\nMake your guess: "
        guessWord(gets.to_s.chomp)
        turn += 1
        break if turn > @@maxTurns
      else
        puts 'Please input a number between [1-2]'
      end

    end
  end

  private def saveFile(turn)
    if @fileName == nil
      SaveFiles.save(@incompleteWord, @wordPos, turn)        
    else
      SaveFiles.updateFile(@incompleteWord, @wordPos, turn, @fileName)
    end
  end

  def guessWord(word = ' ')      
    word = word.to_s.chars.first

    correctGuess = false
    @selectedWord.chars.each_with_index do |char, index|
      if word == char
        @incompleteWord[index] = char 
        correctGuess = true
      end
    end

    system 'clear'
    if correctGuess
      puts 'BRAVO! you\'ve made a great guess!'
    else
      puts 'Wrong guess, better luck the next time'
    end
  end

end