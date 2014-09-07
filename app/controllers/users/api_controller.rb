# TODO: Turn into base for USER/API authentication
class Users::ApiController < ApplicationController
  include UserResource

  layout :false

  def invalid_path(ilk)
    render plain: "Unknown #{ilk}", status: 404
  end#invalid_path
end
