class Fake::Address < Faker::Address
  def self.to_liquid
    {
      "city" => self.city,
      "street_name" => self.street_name,
      "street_address" => self.street_address,
      "secondary_address" => self.secondary_address,
      "building_number" => self.building_number,
      "postcode" => self.postcode,
      "time_zone" => self.time_zone,
      "street_suffix" => self.street_suffix,
      "city_suffix" => self.city_suffix,
      "city_prefix" => self.city_prefix,
      "state_abbr" => self.state_abbr,
      "state" => self.state,
      "country" => self.country,
      "latitude" => self.latitude,
      "longitude" => self.longitude
    }
  end#self.to_liquid
end
