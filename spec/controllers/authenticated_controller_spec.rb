require 'rails_helper'

describe AuthenticatedController do
  controller do
    def index
      render json: { good: "show" }
    end
  end
  before(:each) { allow(controller).to receive(:authenticate_user!) }
  it "calls authenticate_user!" do
    get :index
    expect(controller).to have_received(:authenticate_user!)
  end
end
