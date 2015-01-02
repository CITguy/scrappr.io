class Fake::Hacker < Faker::Hacker
  def self.to_liquid
    {
      "abbreviation" => self.abbreviation,
      "adjective" => self.adjective,
      "ingverb" => self.ingverb,
      "noun" => self.noun,
      "phrases" => self.phrases,
      "say_something_smart" => self.say_something_smart,
      "verb" => self.verb
    }
  end#self.to_liquid
end
