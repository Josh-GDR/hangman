class RandomWordChooser
  @@Dictionary = File.read('./lib/english_words.txt').lines
  @@maxTurns = 0

  def initialize
    @selectedWord = ''
    @wordPos = 0

    @incompleteWord = ''
  end

  def startGame
    @wordPos = Random.rand(@@Dictionary.length)
    @selectedWord = @@Dictionary[@wordPos]
    return startGame unless @selectedWord.length.between?(6,13)

    
  end
  
end