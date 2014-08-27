class Api::UsersController < ApiController
  before_action :fetch_user

  protected
  # TODO: TEST
  def fetch_user
    unless @user = User.slug(params[:user_id]).first
      invalid_path("User") if Rails.env.development?
    end
  end#fetch_user
end
