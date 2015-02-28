class Users::Api::ScrapsController < Users::ApiController
  skip_before_filter :verify_authenticity_token

  INTERNAL_PARAMS = [ "controller", "action", "user_id", "scrap", "endpoint" ]

  def show
    @scrap = Scrap.find_by({
      user: @user,
      http_method: request.method,
      endpoint: params[:endpoint]
    })

    if @scrap
      response.headers.merge!(@scrap.http_headers)
      # TODO: TEST called with expected hash
      render @scrap.render_options({
        liquid: liquid_options
      })
    else
      invalid_path("Endpoint")
    end
  end#show

  # https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS
  def preflight
    @scraps = Scrap.where({
      user: @user,
      endpoint: params[:endpoint]
    })

    if @scraps.count > 0
      response.headers.merge!({
        # allow access from anywhere
        "Access-Control-Allow-Origin" => "*",
        # only allow methods supported by scrappr
        "Access-Control-Allow-Methods" => Scrap::HTTP_METHODS.join(','),
        # allow headers by echoing requested headers always matches
        "Access-Control-Allow-Headers" => request.headers["Access-Control-Request-Headers"]
      })

      render :text => "OK", :status => 200
    else
      invalid_path("Endpoint")
    end
  end#preflight

  # "PRIVATE" methods

  # TODO: TEST
  # Fetch a hash of variable-value mappings for use with Liquid rendering.
  #
  # @return [Hash]
  def liquid_options
    {
      "params" => liquid_params,
      "fake" => Fake # (experimental)
    }
  end#liquid_options


  # TODO: TEST
  # Return a params hash, ignoring internal values
  #
  # NOTE: This seems very hacky. Is there a better way of doing this?
  #
  # @return [Hash]
  def liquid_params
    clean = params.dup
    clean.delete_if {|k,_| INTERNAL_PARAMS.include?(k) }
    clean["dump"] = clean.to_json
    clean
  end#liquid_params
end
