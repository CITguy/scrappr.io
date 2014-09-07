class Public::ScrapsController < PublicController
  def index
    filtered_scraps = Scrap.visible.lively
    @scraps = filtered_scraps.page(params[:page])
  end
end
