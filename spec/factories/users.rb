# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  remember_created_at :datetime
#  provider            :string(255)      not null
#  uid                 :string(255)      not null
#  username            :string(255)      not null
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :string(255)
#  last_sign_in_ip     :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  theme_id            :integer          default(1)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "github"
    uid "12345"
    sequence :username do |n|
      "SomeGuy-#{n}"
    end
    association :theme, factory: :editor_theme

    factory :duplicate_user do
      uid "12345"
      provider "github"
      username "Batman"
    end
  end
end
