module UserResource
  extend ActiveSupport::Concern

  included do
    before_action do
      fetch_user(params[:user_id])
    end
  end

  # instance methods
  def fetch_user(username)
    @user = User.find_by!(username: username)
  rescue ActiveRecord::RecordNotFound => e
    invalid_path("Path")
  end#fetch_user
end
