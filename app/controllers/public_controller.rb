class PublicController < ActionController::Base

  # https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS
  def api_preflight
    response.headers.merge!({
      "Access-Control-Allow-Origin" => "*",
      "Access-Control-Allow-Methods" => "*",
      "Access-Control-Allow-Headers" => "*"
    })
    render :text => "OK", :status => 200
  end
end
