require 'yaml'
require 'json'

class SaveFiles
  @@DefaultPath = './SaveStates/'
  @@serializer = YAML
  @@Word = :word
  @@pos = :pos

  def self.pos
    @@pos
  end

  def self.Word
    @@Word
  end

  def self.save(_word, _wordPos)
    Dir.mkdir(@@DefaultPath) unless Dir.exist?(@@DefaultPath)

    file = File.new("#{@@DefaultPath}#{_word}#{self.extentionChooser}", 'w+')
    file.puts @@serializer.dump({
      word: _word,
      pos: _wordPos
    })
  end

  def self.load(_word = ' ') 
    _word.chomp!
    unless File.exist?("#{@@DefaultPath}#{_word}")
      puts "Couldn't open #{_word}, make sure to type the extension and the world correctly"
      retun nil;
    end

    deserializer = getCorrectDeserializer(_word.chars.drop(_word.chars.index('.')).join)
    obj = deserializer.load(File.read("#{@@DefaultPath}#{_word}"))
    return obj
  end

  def self.extentionChooser
    if @@serializer == YAML
      return '.yaml'
    elsif @@serializer == JSON
      return '.json'
    end    
  end

  def self.changeSerializer(extention)
    @@serializer = self.getCorrectDeserializer(extention)
  end

  def self.getCorrectDeserializer(extension)
    if extension.eql?('.yaml')
      return YAML
    elsif extension.eql?('.json')
      return JSON
    end
  end

end