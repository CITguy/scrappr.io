# == Schema Information
#
# Table name: http_response_headers
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  status      :string(255)      default("nonstandard"), not null
#  description :text
#

class HttpResponseHeader < ActiveRecord::Base
  VALID_STATUSES = [ "provisional", "permanent", "unregistered", "nonstandard" ].freeze

  validates :name,
            presence: true,
            uniqueness: true

  validates :status,
            presence: true,
            inclusion: { in: VALID_STATUSES }

  def self.options_for_select
    all.order(:name => :asc).pluck(:name)
  end

end#HttpResponseHeader
