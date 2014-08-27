class HoodooController < AuthenticatedController
  def index
    render text: "Hello World!"
  end
end
