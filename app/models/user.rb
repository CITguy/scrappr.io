# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  remember_created_at :datetime
#  provider            :string(255)      not null
#  uid                 :string(255)      not null
#  username            :string(255)      not null
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :string(255)
#  last_sign_in_ip     :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  theme_id            :integer          default(1)
#

class User < ActiveRecord::Base
  # Omniauth-ONLY Login
  devise :omniauthable, :rememberable, :trackable

  validates :provider,
            presence: true

  validates :uid,
            presence: true
            # NOTE: Only necessary if more OAuth providers added
            #uniqueness: { scope: [:provider] }

  validates :username,
            presence: true,
            uniqueness: true

  has_many :scraps

  belongs_to :theme, class: EditorTheme


  # @param [OmniAuth::AuthHash] auth
  #
  # @return [User]
  def self.from_omniauth(auth)
    Rails.logger.debug("OAUTH: #{auth.inspect}")
    # Modified due to change in Railties 4.1.5 regarding CVE-2014-3514
    params = ActionController::Parameters.new(user: auth.slice(:provider, :uid))
    permitted = params.require(:user).permit(:provider, :uid)

    where(permitted).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
    end
  end#self.from_omniauth


  # Generate full URL to avatar image from provider
  #
  # @return [String]
  def avatar_url
    "https://avatars.githubusercontent.com/u/#{uid}?v=2"
  end


  # Returns Username as Param
  #
  # @return [String]
  def to_param
    self.username
  end#to_param
end#User
