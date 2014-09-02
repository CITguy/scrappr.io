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

class StatusCode < ActiveRecord::Base
  validates :number,
            presence: true

  validates :desc,
            presence: true,
            uniqueness: { scope: [:number] }

  validates :is_standard,
            inclusion: { in: [true, false] }


  # Build Array of #option_text for every record in database
  #
  # @return [Array]
  def self.options_for_select
    all.map do |status_code|
      [status_code.option_text, status_code.number]
    end
  end#self.options_for_select


  # Format instance string for use with select <option>s in HTML
  #
  # @return [String]
  def option_text
    "#{self.number} - #{self.desc}"
  end
end#StatusCode
