class Api::Users::PilesController < Api::UsersController
  before_action :fetch_pile

  protected
  # TODO: TEST
  def fetch_pile
    unless @pile = @user.piles.from_param(params[:pile_id]).first
      invalid_path("Pile") if Rails.env.development?
    end
  end#fetch_pile
end
