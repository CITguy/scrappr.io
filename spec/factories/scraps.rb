# == Schema Information
#
# Table name: scraps
#
#  id                 :integer          not null, primary key
#  http_method        :string(255)      default("GET"), not null
#  endpoint           :string(255)      not null
#  status_code        :integer          default(200), not null
#  content_type       :string(255)      default("application/json"), not null
#  body               :text             not null
#  private            :boolean          default(FALSE), not null
#  character_encoding :string(255)      default("UTF-8"), not null
#  pile_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scrap do
    endpoint "foo/bar/baz"
    content_type "application/json"
    body "Hello World"
    user
  end
end
