class Fake::CreditCard < Faker::Business
  def self.to_liquid
    out = {
      "number" => self.credit_card_number,
      "type" => self.credit_card_type,
      "expiry" => self.credit_card_expiry_date,
    }

    ## BROKE: Numbers don't return in consistent format
    #Faker::Finance::CREDIT_CARD_TYPES.each do |ilk|
    #  out["#{ilk}"] = Faker::Finance.credit_card(ilk)
    #end

    out
  end#self.to_liquid
end
