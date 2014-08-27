class Users::Piles::ScrapsController < Users::PilesController
  before_action :fetch_user_pile
  before_action :fetch_scrap, only: [:show, :edit, :update, :destroy]
  before_action do
    add_breadcrumb @pile.name, user_pile_path(@user, @pile)
    add_breadcrumb "Scraps"
  end

  before_action only: [:show, :edit] do
    add_breadcrumb "/#{@scrap.endpoint}", user_pile_scrap_path(@user, @pile, @scrap)
  end

  def show
  end

  def edit
    add_breadcrumb "Edit"
  end

  def update
    @scrap.update_attributes(scrap_attributes)
    if @scrap.save
      flash[:notice] = "Scrap Updated"
      redirect_to user_pile_scrap_path(@user, @pile, @scrap)
    else
      flash.now[:alert] = "Scrap Could not be updated: #{@scrap.errors.full_messages}"
      render :edit
    end
  end

  def destroy
  end

  protected
  def fetch_scrap
    @scrap = @pile.scraps.find(params[:id])
  end

  private
  def scrap_attributes
    params.require(:scrap).permit(:http_method, :endpoint, :content_type, :status_code, :body)
  end
end
