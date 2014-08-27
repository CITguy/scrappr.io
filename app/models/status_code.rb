# == Schema Information
#
# Table name: status_codes
#
#  id       :integer          not null, primary key
#  number   :integer          not null
#  desc     :string(255)      not null
#  standard :boolean          default(FALSE), not null
#  rfc      :string(255)
#

class StatusCode < ActiveRecord::Base
  validates :number,
            :presence => true

  validates :desc,
            :presence => true

  validates :standard,
            :inclusion => { :in => [true, false] }
end#StatusCode
