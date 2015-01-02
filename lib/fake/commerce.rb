class Fake::Commerce < Faker::Commerce
  def self.to_liquid
    {
      "color" => self.color,
      "department" => self.department,
      "price" => self.price,
      "product_name" => self.product_name
    }
  end#self.to_liquid
end
