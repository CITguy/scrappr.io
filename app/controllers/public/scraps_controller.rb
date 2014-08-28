class Public::ScrapsController < PublicController
  def index
    # Get 10 most recent scraps
    @scraps = Scrap.publicly_available.recent.limit(10)
  end
end
