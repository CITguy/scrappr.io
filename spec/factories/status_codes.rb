# == Schema Information
#
# Table name: status_codes
#
#  id          :integer          not null, primary key
#  number      :integer          not null
#  desc        :string(255)      not null
#  is_standard :boolean          default(FALSE), not null
#  rfc         :string(255)
#

FactoryGirl.define do
  factory :status_code do
    sequence :number do |n|
      100 + n
    end
    sequence :desc do |n|
      "Some Description ##{n}"
    end

    is_standard false

    factory :dupe_status_code do
      number 42
      desc "The Answer to the Ultimate Question of Life, the Universe, and Everything"
    end
  end
end
