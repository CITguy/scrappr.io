# == Schema Information
#
# Table name: content_types
#
#  id  :integer          not null, primary key
#  ilk :string(255)      not null
#

class ContentType < ActiveRecord::Base
  validates :ilk,
            :presence => true,
            :uniqueness => true
end#ContentType
