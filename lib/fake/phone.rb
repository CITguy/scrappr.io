class Fake::Phone < Faker::PhoneNumber
  def self.to_liquid
    {
      "area_code" => self.area_code,
      "cell_phone" => self.cell_phone,
      "exchange_code" => self.exchange_code,
      "phone_number" => self.phone_number,
      "extension" => self.extension,
      "subscriber_number" => self.subscriber_number
    }
  end#self.to_liquid
end
