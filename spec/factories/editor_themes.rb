# == Schema Information
#
# Table name: editor_themes
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  ilk        :string(255)      default("light"), not null
#  is_enabled :boolean          default(TRUE), not null
#  ace_id     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :editor_theme, aliases: [:light_editor_theme] do
    name "MyString"
    ilk "light"
    is_enabled true
    sequence :ace_id do |n|
      "my_string_#{n}"
    end

    factory :dark_editor_theme do
      ilk "dark"
    end

    factory :duplicate_editor_theme do
      ace_id "dupe_theme"
    end
  end
end
