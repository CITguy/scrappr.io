require "rails_helper"

describe Api::UsersController do
  let(:controller) { "api/users" }
  describe "(routes)" do
    describe "GET /api/users" do
      it "should not be routable" do
        expect(get: "/api/users").to_not be_routable
      end
    end
    describe "GET /api/users/:id" do
      it "should not be routable" do
        expect(get: "/api/users/123").to_not be_routable
      end
    end
    describe "GET /api/users/new" do
      # no way to test without complicated route conditions
    end
    describe "POST /api/users" do
      it "should not be routable" do
        expect(post: "/api/users").to_not be_routable
      end
    end
    describe "GET /api/users/:id/edit" do
      it "should not be routable" do
        expect(get: "/api/users/123/edit").to_not be_routable
      end
    end
    describe "PUT /api/users/:id" do
      let(:path) { "/api/users/123" }
      it "should be routable" do
        expect(put: path).to be_routable
      end
      it "should route correctly" do
        expect(put: path).to route_to("api/users#update", id: "123")
      end
    end
    describe "PATCH /api/users/:id" do
      let(:path) { "/api/users/123" }
      it "should be routable" do
        expect(patch: path).to be_routable
      end
      it "should route correctly" do
        expect(patch: path).to route_to("api/users#update", id: "123")
      end
    end
    describe "DELETE /api/users/:id" do
      it "should not be routable" do
        expect(delete: "/api/users/123").to_not be_routable
      end
    end
  end
end
