class Users::Api::ScrapsController < Users::ApiController
  # TODO: TEST
  def show
    if @scrap = @user.scraps.from_param(params[:endpoint]).first
      response.headers.merge!(@scrap.http_headers)
      render @scrap.render_options
    else
      invalid_path("Scrap") if Rails.env.development?
    end
  end#show
end
