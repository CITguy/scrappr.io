# == Schema Information
#
# Table name: content_types
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#

FactoryGirl.define do
  factory :content_type do
    sequence :name do |n|
      "application/foobar-#{n}"
    end

    factory :duplicate_name_content_type do
      name "application/duplicate"
    end
  end
end
