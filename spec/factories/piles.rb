# == Schema Information
#
# Table name: piles
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :text
#  protected   :boolean          default(FALSE), not null
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pile do
    sequence :name do |n|
      "Pile Cleanup Later #{n}"
    end
    user
  end
end
