class Users::Api::ScrapsController < Users::ApiController
  skip_before_filter :verify_authenticity_token

  def show
    @scrap = Scrap.find_by({
      user: @user,
      http_method: request.method,
      endpoint: params[:endpoint]
    })

    if @scrap
      response.headers.merge!(@scrap.http_headers)
      render @scrap.render_options
    else
      invalid_path("Endpoint")
    end
  end#show
end
