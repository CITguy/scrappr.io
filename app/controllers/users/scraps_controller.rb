class Users::ScrapsController < UsersController
  include UserResource

  def index
    base_condition = (viewing_own_resource? ? @user.scraps : @user.scraps.visible)
    @scraps = base_condition.lively
  end#index


  def show
    @scrap = @user.scraps.find(params[:id])
  rescue ActiveRecord::RecordNotFound => err
    redirect_to user_scraps_path(@user), alert: "Scrap Not Found"
  end#show


  def raw
    @scrap = @user.scraps.find(params[:id])
    render text: @scrap.body, content_type: "text/plain"
  rescue ActiveRecord::RecordNotFound => err
    render text: "Scrap Not Found", status: 404, content_type: "text/plain"
  end#raw

########################################
## Authorized with CanCanCan
########################################

  def new
    @scrap = @user.scraps.build
    authorize! :create, @scrap
  end#new


  def edit
    @scrap = @user.scraps.find(params[:id])
    authorize! :edit, @scrap
  end#edit


  def create
    @scrap = @user.scraps.new(scrap_attributes)
    authorize! :create, @scrap
    if @scrap.save
      flash[:notice] = "Scrap Saved"
      redirect_to user_scrap_path(@user, @scrap)
    else
      flash.now[:alert] = "Scrap Could not be Saved: #{@scrap.errors.full_messages}"
      render :new
    end
  end


  def update
    @scrap = @user.scraps.find(params[:id])
    authorize! :update, @scrap
    if @scrap.update_attributes(scrap_attributes)
      flash[:notice] = "Scrap Updated"
      redirect_to user_scrap_path(@user, @scrap)
    else
      flash.now[:alert] = "Scrap Could not be updated: #{@scrap.errors.full_messages}"
      render :edit
    end
  end#update


  def destroy
    @scrap = @user.scraps.find(params[:id])
    authorize! :destroy, @scrap
    if @scrap.destroy
      flash[:notice] = "Scrap destroyed"
      redirect_to user_scraps_path(@user)
    else
      flash[:alert] = "Could not destroy scrap"
      redirect_to user_scrap_path(@user, @scrap)
    end
  end#destroy


  #private
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
