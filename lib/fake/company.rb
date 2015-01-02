class Fake::Company < Faker::Company
  def self.to_liquid
    {
      "bs" => self.bs,
      "catch_phrase" => self.catch_phrase,
      "duns_number" => self.duns_number,
      "ein" => self.ein,
      "name" => self.name,
      "suffix" => self.suffix
    }
  end#self.to_liquid
end
