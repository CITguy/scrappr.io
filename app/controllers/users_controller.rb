class UsersController < ApplicationController

  protected
  # TODO: TEST
  def fetch_user
    @user = User.from_param(params[:user_id]).first!
  rescue => e
    redirect_to root_path, alert: "Invalid Path"
  end#fetch_user

  # TODO: TEST
  def viewing_own_resource?
    false unless current_user
    current_user == @user
  end#viewing_own_resource?
end
