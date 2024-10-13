require 'yaml'
require 'json'

class SaveFiles
  @@DefaultPath = './SaveStates/'
  @@serializer = YAML
  
  def self.serializer=(_serializer)
    @@serializer = _serializer
  end

  def self.save(_word = '', _wordPos = 0, _turn = 0)
    Dir.mkdir(@@DefaultPath) unless Dir.exist?(@@DefaultPath)
    fileName = "ST#" << Dir.glob("#{@@DefaultPath}/**/*").count.to_s
    self.writeFile(fileName, _word, _wordPos, _turn)
  end

  def self.updateFile(_word, _wordPos, _turn, fileName)
    Dir.mkdir(@@DefaultPath) unless Dir.exist?(@@DefaultPath)
    writeFile(fileName.chars.take(fileName.chars.index('.')).join, _word, _wordPos, _turn)    
  end

  def self.writeFile(fileName, _word, _wordPos, _turn)
    File.write("#{@@DefaultPath}#{fileName}#{self.extentionChooser}", @@serializer.dump({
      word: _word,
      pos: _wordPos,
      turn: _turn
    }))
  end

  def self.load(_word = ' ') 
    _word.chomp!
    unless File.exist?("#{@@DefaultPath}#{_word}")
      puts "Couldn't open #{_word}, make sure to type the extension and the world correctly"
      retun nil;
    end

    deserializer = getCorrectDeserializer(_word.chars.drop(_word.chars.index('.')).join)
    deserializer.load(File.read("#{@@DefaultPath}#{_word}"))
  end

  def self.extentionChooser
    if @@serializer == YAML
      return '.yaml'
    elsif @@serializer == JSON
      return '.json'
    end    
  end

  def self.getCorrectDeserializer(extension)
    if extension.eql?('.yaml')
      return YAML
    elsif extension.eql?('.json')
      return JSON
    end
  end

end