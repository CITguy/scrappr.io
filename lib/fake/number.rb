class Fake::Number < Faker::Number
  def self.to_liquid
    {
      "digit" => self.digit,
      "small" => self.between(1.00, 100.00),
      "medium" => self.between(100.00, 1000.00),
      "large" => self.between(1000.00, 1_000_000.00),
      "extra_large" => self.between(1_000_000.00, 1_000_000_000_000.00)
    }
  end#self.to_liquid
end
