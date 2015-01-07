class PublicPagesController < ActionController::Base
  def status
    render text: "OK", status: 200
  end#status

  def about
  end#about
end#PublicPagesController
