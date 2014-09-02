class UserSessionsController < Devise::OmniauthCallbacksController

  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash[:notice] = "Signed In"
      sign_in_and_redirect user
    else
      redirect_to root_url, alert: "Problem signing in with Github"
    end
  end#all

  # ROUTING: Tested
  alias_method :github, :all


  # ROUTING: Tested
  def destroy
    sign_out_all_scopes
    redirect_to root_path, notice: "Signed Out"
  end#destroy

end#UserSessionsController
