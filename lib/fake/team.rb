class Fake::Team < Faker::Team
  def self.to_liquid
    {
      "creature" => self.creature,
      "name" => self.name,
      "state" => Faker::Address.state.titleize
    }
  end#self.to_liquid
end
