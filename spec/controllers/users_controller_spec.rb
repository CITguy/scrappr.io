require 'rails_helper'

describe UsersController do

  describe "#viewing_own_resource?" do
    let(:result) { controller.viewing_own_resource? }
    it "responds" do
      expect(controller).to respond_to(:viewing_own_resource?)
    end
    it "returns false without current_user" do
      allow(controller).to receive(:current_user).and_return(nil)
      expect(result).to eq(false)
    end
    it "returns false if current username is different from user_id param" do
      allow(controller).to receive(:current_user).and_return(FactoryGirl.create(:user))
      controller.params[:user_id] = FactoryGirl.attributes_for(:user)[:username]
      expect(result).to eq(false)
    end
    it "returns true if current username is same as user_id param" do
      same_user = FactoryGirl.create(:user)
      allow(controller).to receive(:current_user).and_return(same_user)
      controller.params[:user_id] = same_user.username
      expect(result).to eq(true)
    end
  end#viewing_own_resource?

  context "rescue CanCan::AccessDenied" do
    controller do
      def index
        render json: { good: "show" }.to_json
      end
    end
    let(:err) { CanCan::AccessDenied }
    before(:each) do
      @user = FactoryGirl.create(:user)
      allow(controller).to receive(:index).and_raise(err)
      get :index, user_id: @user
    end
    it "doesn't error" do
      expect{ get :index, user_id: @user }.to_not raise_error
    end
    it "redirects to user_scraps_path" do
      expect(response).to redirect_to(user_scraps_path(@user))
    end
    it "sets flash alert" do
      expect(flash[:alert]).to eq(UsersController::UNAUTHORIZED_MESSAGE)
    end
  end
end
