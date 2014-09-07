require "rails_helper"

describe Public::ScrapsController do
  describe "#index" do
    before(:each) { get :index }
    it "is successful" do
      expect(response).to be_successful
    end
    it "assigns @scraps" do
      expect(assigns(:scraps)).to_not be_nil
    end
    context "with existing scraps" do
      before(:each) { FactoryGirl.create_list(:scrap, 12) }
      it "retrieves a max of 10 results" do
        expect(assigns(:scraps).count).to be <= 10
      end
    end#with existing scraps
  end#index
end
