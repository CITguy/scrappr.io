require "rails_helper"

describe UserSessionsController do
  describe "(routes)" do
    let(:controller) { "user_sessions" }

    [ "github" ].each do |provider|
      context "#{provider} - authorize" do
        let(:path) { "/users/auth/#{provider}" }
        describe "GET /users/auth/#{provider}" do
          it "should be routable" do
            expect( get: path ).to be_routable
          end
          it "should route to user_sessions#passthru" do
            expect( get: path ).to route_to(controller: controller, action: "passthru", provider: provider)
          end
        end
        describe "POST /users/auth/#{provider}" do
          it "should be routable" do
            expect( post: path ).to be_routable
          end
          it "should route to user_sessions#passthru" do
            expect( post: path ).to route_to(controller: controller, action: "passthru", provider: provider)
          end
        end
      end#authorize
      context "#{provider} - callback" do
        let(:path) { "/users/auth/#{provider}/callback" }
        describe "GET /users/auth/#{provider}/callback" do
          it "should be routable" do
            expect(get: path).to be_routable
          end
          it "should route correctly" do
            expect(get: path).to route_to(controller: "user_sessions", action: provider)
          end
        end
        describe "POST /users/auth/#{provider}/callback" do
          it "should be routable" do
            expect(post: path).to be_routable
          end
          it "should route correctly" do
            expect(post: path).to route_to(controller: "user_sessions", action: provider)
          end
        end
      end#callback
    end

    context "DELETE /logout" do
      it "should be routable" do
        expect( delete: "/logout" ).to be_routable
      end
      it "should route correctly" do
        expect( delete: "/logout" ).to route_to(controller: controller, action: "destroy")
      end
    end#DELETE /logout
  end#(routes)
end#UserSessionsController
