# == Schema Information
#
# Table name: content_types
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#

class ContentType < ActiveRecord::Base
  # TODO: TEST
  validates :name,
            :presence => true,
            :uniqueness => true
end#ContentType
