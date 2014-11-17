class Fake
  def self.to_liquid
    {
      "address" => Fake::Address,
      "bitcoin" => Fake::Bitcoin,
      "commerce" => Fake::Commerce,
      "company" => Fake::Company,
      "credit_card" => Fake::CreditCard,
      "hacker" => Fake::Hacker,
      "internet" => Fake::Internet,
      "lorem" => Fake::Lorem,
      "name" => Fake::Name,
      "number" => Fake::Number,
      "phone" => Fake::Phone,
      "team" => Fake::Team
    }.tap { |h| h["to_json"] = h.to_json }
  end
end
