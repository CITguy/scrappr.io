# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  remember_created_at :datetime
#  provider            :string(255)      not null
#  uid                 :string(255)      not null
#  username            :string(255)      not null
#  created_at          :datetime
#  updated_at          :datetime
#

class User < ActiveRecord::Base
  # Omniauth-ONLY Login
  devise :omniauthable, :rememberable

  validates :username,
            presence: true,
            uniqueness: true # TODO: TEST in scope of provider

  # TODO: uniqueness of uid in scope of provider
  #validates :uid, uniqueness: { scope: [:provider] }

  has_many :piles


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
    end
  end#self.from_omniauth


  def self.from_param(slug)
    where(username: slug)
  end#self.from_param


  def to_param
    self.username
  end#to_param
end#User
