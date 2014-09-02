# == Schema Information
#
# Table name: http_response_headers
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  status      :string(255)      default("nonstandard"), not null
#  description :text
#

FactoryGirl.define do
  factory :http_response_header do
    sequence :name do |n|
      "X-Okie-Dokie-#{n}"
    end

    factory :dupe_name_http_response_header do
      name "DupityDoo"
    end
  end
end
