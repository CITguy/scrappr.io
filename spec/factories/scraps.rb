# == Schema Information
#
# Table name: scraps
#
#  http_method        :string(255)      default("GET"), not null
#  endpoint           :string(255)      not null
#  status_code        :integer          default(200), not null
#  content_type       :string(255)      default("application/json"), not null
#  body               :text             not null
#  is_public          :boolean          default(TRUE), not null
#  description        :text
#  language           :string(255)      default("json"), not null
#  character_encoding :string(255)      default("UTF-8"), not null
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  uid                :string(255)      not null, primary key
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scrap do
    sequence :endpoint do |e|
      "foo/bar/baz/#{e}"
    end
    content_type "application/json"
    body %Q{["Hello World"]}
    http_method "GET"
    description do
      "Lorem ipsum dolor sit amet, vix utroque constituto id, regione inermis expetendis pri cu. Eu doctus legendos ius. Mei ea eros eirmod tincidunt, mea te dolor homero theophrastus."
    end
    # Associations
    user

    factory :visible_scrap do
      is_public true
    end

    factory :invisible_scrap do
      is_public false
    end

    factory :duplicate_scrap do
      endpoint "wakka/wakka/wakka"
      http_method "GET"
    end
  end
end
