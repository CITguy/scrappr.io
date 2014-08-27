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

class Pile < ActiveRecord::Base
  validates :name,
            presence: true,
            uniqueness: { scope: [:user] }

  validates :user,
            presence: true

                  # TODO: TEST
  has_many :scraps#, dependent: :destroy

  belongs_to :user

  before_save do
    self.slug = self.to_param
  end


  def self.from_param(slug)
    where(slug: slug)
  end#self.from_param


  # @return [String]
  def to_param
    self.name.parameterize
  end#to_param
end#Pile
