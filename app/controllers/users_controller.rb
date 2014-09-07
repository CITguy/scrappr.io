class UsersController < ApplicationController
  include UserResource

  UNAUTHORIZED_MESSAGE = "Shame on you! Please play with your own stuff!"
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.user_scraps_path(@user), :alert => UNAUTHORIZED_MESSAGE
  end


  # SHARED METHODS

  # @return [Boolean]
  def viewing_own_resource?
    return false unless current_user
    current_user.username == params[:user_id]
  end#viewing_own_resource?
end
