class UsersController < ApplicationController

  protected
  # TODO: TEST
  def fetch_user
    @user = User.from_param(params[:user_id]).first!
  rescue => e
    redirect_to root_path, alert: "Invalid Path"
  end#fetch_user
end
