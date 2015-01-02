class Fake::Lorem < Faker::Lorem
  def self.to_liquid
    {
      "character" => self.character,
      "characters" => self.characters,
      "paragraph" => self.paragraph,
      "paragraphs" => self.paragraphs,
      "sentence" => self.sentence,
      "sentences" => self.sentences,
      "word" => self.word,
      "words" => self.words
    }
  end#self.to_liquid
end
