class Fake::Bitcoin < Faker::Bitcoin
  def self.to_liquid
    {
      "address" => self.address
    }
  end#self.to_liquid
end
