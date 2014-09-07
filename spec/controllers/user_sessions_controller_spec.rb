require 'rails_helper'

describe UserSessionsController do
  include Devise::TestHelpers

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#github" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      allow(User).to receive(:from_omniauth).with(anything).and_return(@user)
    end
    context "with persisted user" do
      before(:each) do
        allow(@user).to receive(:persisted?).and_return(true)
        get :github
      end
      it "redirects to root path" do
        expect(response).to redirect_to(root_path)
      end
      it "sets flash" do
        expect(flash[:notice]).to eq("Signed In")
      end
    end
    context "with non-persisted user" do
      before(:each) do
        allow(@user).to receive(:persisted?).and_return(false)
        get :github
      end
      it "redirects to root path" do
        expect(response).to redirect_to(root_path)
      end
      it "sets flash" do
        expect(flash[:alert]).to eq("Problem signing in with Github")
      end
    end
  end#github

  describe "#destroy" do
    before(:each) { delete :destroy }
    it "redirects to root_path" do
      expect(response).to redirect_to(root_path)
    end
    it "sets flash[:notice]" do
      expect(flash[:notice]).to eq("Signed Out")
    end
  end#destroy
end
