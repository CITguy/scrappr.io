# TODO: AUTHENTICATED CONTROLLER OF SOME SORT
class Users::ApiController < UsersController
  before_action :fetch_user

  layout :false

  # TODO: TEST
  def invalid_path(ilk="Endpoint")
    render plain: "Unknown #{ilk}", status: 404
  end#invalid_path
end
