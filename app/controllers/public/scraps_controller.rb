class Public::ScrapsController < PublicController
  include ScrapSorting

  def index
    arel = apply_sorting(Scrap.visible, params[:sort])
    @scraps = arel.page(params[:page])
  end#index
end
