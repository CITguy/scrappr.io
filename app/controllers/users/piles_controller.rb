class Users::PilesController < UsersController
  before_action :fetch_user

  before_action do
    add_breadcrumb @user.to_param
    add_breadcrumb "Piles", user_piles_path(@user)
  end


  # GET
  def index
    @piles = @user.piles
  end#index


  # GET
  def show
    fetch_pile
    add_breadcrumb @pile.name, user_pile_path(@user, @pile)
    @scraps = @pile.scraps
  end#show


  # GET
  def new
    add_breadcrumb "New"
    @pile = @user.piles.build
  end#new


  # GET
  def edit
    fetch_pile
    add_breadcrumb @pile.name, user_pile_path(@user, @pile)
    add_breadcrumb "Edit"
  end#edit


  # POST
  def create
    @pile = Pile.new(pile_params)
    @pile.user = @user
    if @pile.save
      flash[:notice] = "Pile Created: #{@pile.name}"
      redirect_to user_piles_path(@user)
    else
      flash.now[:alert] = "Pile could not be created: (#{@pile.errors.full_messages})"
      render :new
    end
  end#create


  # PUT/PATCH
  def update
    fetch_pile
    @pile.update_attributes(pile_params)
    if @pile.save
      flash[:notice] = "Pile Updated!"
      redirect_to user_pile_path(@user, @pile)
    else
      flash.now[:alert] = "Pile could not be updated: (#{@pile.errors.full_messages})"
      render :edit
    end
  end#update


  # DELETE
  def destroy
    fetch_pile
    if @pile.destroy
      flash[:notice] = "Pile Destroyed"
      redirect_to user_piles_path(@user)
    else
      flash[:alert] = "Pile Not Destroyed"
      redirect_to :back
    end
  end#destroy

  protected

  def fetch_pile
    @pile = Pile.from_param(params[:id]).first!
  end

  def fetch_user_pile
    @pile = @user.piles.from_param(params[:pile_id]).first!
  end


  private

  def pile_params
    params.require(:pile).permit(:name, :description)
  end
end
