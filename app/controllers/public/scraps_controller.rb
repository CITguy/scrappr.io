class Public::ScrapsController < PublicController
  def index
    # Get 10 most recent scraps
    scraps = Scrap.visible.lively.limit(10)
    @scraps = scraps.page(params[:page])
  end
end
