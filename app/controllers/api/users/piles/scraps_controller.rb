class Api::Users::Piles::ScrapsController < Api::Users::PilesController
  # TODO: TEST
  def show
    if @scrap = @pile.scraps.from_param(params[:scrap_endpoint]).first
      response.headers.merge!(@scrap.http_headers)
      render @scrap.render_options
    else
      invalid_path("Scrap") if Rails.env.development?
    end
  end#show
end
