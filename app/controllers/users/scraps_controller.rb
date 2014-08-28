class Users::ScrapsController < UsersController
  before_action :fetch_user

  before_action :fetch_scrap, only: [:show, :edit, :update, :destroy]
  before_action do
    add_breadcrumb @user.username
    add_breadcrumb "Scraps", user_scraps_path(@user)
  end

  before_action only: [:show, :edit] do
    add_breadcrumb "/#{@scrap.endpoint}", user_scrap_path(@user, @scrap)
  end

  def index
    @scraps = @user.scraps
  end

  def show
  end

  def new
    @scrap = @user.scraps.build
  end

  def edit
    add_breadcrumb "Edit"
  end

  def create
    @scrap = @user.scraps.new(scrap_attributes)
    if @scrap.save
      flash[:notice] = "Scrap Saved"
      redirect_to user_scrap_path(@user, @scrap)
    else
      flash.now[:alert] = "Scrap Could not be Saved: #{@scrap.errors.full_messages}"
      render :new
    end
  end

  def update
    @scrap.update_attributes(scrap_attributes)
    if @scrap.save
      flash[:notice] = "Scrap Updated"
      redirect_to user_scrap_path(@user, @scrap)
    else
      flash.now[:alert] = "Scrap Could not be updated: #{@scrap.errors.full_messages}"
      render :edit
    end
  end

  def destroy
  end

  protected
  def fetch_scrap
    @scrap = @user.scraps.find(params[:id])
  end

  private
  def scrap_attributes
    params.require(:scrap).permit(:http_method, :endpoint, :content_type, :status_code, :body)
  end
end
