class Users::ScrapsController < UsersController
  before_action :fetch_user

  UNAUTHORIZED_MESSAGE = "Shame on you! Don't mess with other people's stuff!"
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.user_scraps_path(@user), :alert => UNAUTHORIZED_MESSAGE
  end

  before_action :fetch_scrap, only: [:show, :edit, :update, :destroy]

  def index
    base_condition = (viewing_own_resource? ? @user.scraps : @user.scraps.visible)
    @scraps = base_condition.lively
  end

  def show
  end

  def new
    #authorize! :create, Scrap
    @scrap = @user.scraps.build
  end

  def edit
    authorize! :edit, @scrap
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
    if @scrap.destroy
      flash[:notice] = "Scrap destroyed"
      redirect_to user_scraps_path(@user)
    else
      flash[:alert] = "Could not destroy scrap"
      redirect_to user_scrap_path(@user, @scrap)
    end
  end

  def raw
    @scrap = @user.scraps.find(params[:id])
    render text: @scrap.body, content_type: :plain
  rescue ActiveRecord::RecordNotFound => err
    render text: "Scrap Not Found", status: 404, content_type: :plain
  end

  protected
  def fetch_scrap
    @scrap = @user.scraps.find(params[:id])
  end

  private
  def scrap_attributes
    params.require(:scrap).permit(
      :http_method,
      :endpoint,
      :content_type,
      :status_code,
      :body,
      :description,
      :language,
      :is_public
    )
  end#scrap_attributes
end
