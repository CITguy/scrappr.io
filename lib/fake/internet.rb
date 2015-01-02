class Fake::Internet < Faker::Internet
  def self.to_liquid
    {
      "domain_name" => self.domain_name,
      "domain_suffix" => self.domain_suffix,
      "domain_word" => self.domain_word,
      "email" => self.email,
      "free_email" => self.free_email,
      "ipv4_address" => self.ip_v4_address,
      "ipv6_address" => self.ip_v6_address,
      "mac_address" => self.mac_address,
      "password" => self.password,
      "safe_email" => self.safe_email,
      "slug" => self.slug, # expose?
      "url" => self.url,
      "user_name" => self.user_name
    }
  end#self.to_liquid
end
