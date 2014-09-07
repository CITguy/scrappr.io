class Api::UsersController < ApiController
  def update
    @user = User.find_by!(username: params[:id])
    @theme = EditorTheme.where(ace_id: params[:theme]).first
    if @theme
      if @user.update(theme: @theme)
        render remembered(@theme.ace_id)
      else
        render broken_update(@user.errors.full_messages)
      end
    else
      render unknown_theme(params[:theme])
    end
  rescue ActiveRecord::RecordNotFound => e
    render broken_update("Unknown User")
  end#update


  # @param [String] theme
  # @return [Hash]
  def remembered(theme)
    {
      status: 200,
      json: {
        message: "Remembered Theme '#{theme}'"
      }.to_json
    }
  end#remembered


  # @param [String] theme theme id
  # @return [Hash]
  def unknown_theme(theme)
    broken_update("Unknown Theme '#{theme}'")
  end#unknown_theme


  # @param [String] errors Error string for json[:errors] output
  # @return [Hash]
  def broken_update(errors)
    {
      status: 500,
      json: {
        message: "Cannot Remember Theme",
        errors: errors
      }.to_json
    }
  end#broken_update
end
