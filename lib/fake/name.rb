class Fake::Name < Faker::Name
  def self.to_liquid
    {
      "first_name" => self.first_name,
      "full_name" => self.name,
      "last_name" => self.last_name,
      "middle_initial" => ("A".."Z").to_a.sample,
      "prefix" => self.prefix,
      "suffix" => self.suffix,
      "title" => self.title
    }
  end#self.to_liquid
end
