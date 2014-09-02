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

class EditorTheme < ActiveRecord::Base

  validates :name,
            presence: true

  validates :ilk,
            inclusion: { in: ["light", "dark"] }

  validates :is_enabled,
            inclusion: { in: [true, false] }

  validates :ace_id,
            presence: true,
            uniqueness: true

  scope :enabled, ->{ where( is_enabled: true ) }
  scope :disabled, ->{ where( is_enabled: false ) }
  scope :light, ->{ where( ilk: "light" ) }
  scope :dark, ->{ where( ilk: "dark" ) }

  has_many :users

  # Build Grouped options for Enabled Themes
  #
  # @return [Array]
  def self.grouped_options_for_select
    [
      ["Light", self.enabled.light.collect(&:to_option)],
      ["Dark",  self.enabled.dark.collect(&:to_option)]
    ]
  end#self.grouped_options_for_select


  # Convert theme to array for use with form helpers
  #
  # @return [Array]
  def to_option
    [self.name, self.ace_id]
  end#to_option
end
