class Api::UsersController < ApiController
  # TODO: TEST
  def update
    @user = User.from_param(params[:id]).first!
    @theme = EditorTheme.where(ace_id: params[:theme]).first
    if @theme
      #@user.theme = @theme
      if @user.update(theme: @theme)
        render json: { message: "Remembered Theme '#{@theme.ace_id}'" }.to_json, status: 200
      else
        render json: { message: "Cannot Remember Theme", errors: @user.errors.full_messages }.to_json, status: 500
      end
    else
      render json: { message: "Cannot Remember Theme", errors: "Unknown Theme '#{params[:theme]}'" }.to_json, status: 500
    end
  end
end
