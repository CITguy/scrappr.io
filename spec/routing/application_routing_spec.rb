require "rails_helper"

describe ApplicationController do
  describe "(routes)" do
    describe "GET /" do
      it "should be routable" do
        expect( get: "/" ).to be_routable
      end
      it "should route to public/scraps#index" do
        expect( get: "/" ).to route_to("public/scraps#index")
      end
    end
  end#(routes)
end
