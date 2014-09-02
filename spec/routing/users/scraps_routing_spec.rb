require "rails_helper"

describe Users::ScrapsController do
  let(:controller) { "users/scraps" }
  describe "(routes)" do
    ["FuBaur", "BayngBizz"].each do |user|
      describe "User #{user}" do
        collection_path = "/users/#{user}/scraps"
        member_path = "#{collection_path}/1"
        # INDEX
        context "GET #{collection_path}" do
          let(:path) { collection_path }
          it "should be routable" do
            expect(get: path).to be_routable
          end
          it "should route correctly" do
            expect(get: path).to route_to(controller: controller, action: "index", user_id: user)
          end
        end
        # NEW
        context "GET #{collection_path}/new" do
          let(:path) { "#{collection_path}/new" }
          it "should be routable" do
            expect(get: path).to be_routable
          end
          it "should route correctly" do
            expect(get: path).to route_to(controller:controller, action: "new", user_id: user)
          end
        end
        # CREATE
        context "POST #{collection_path}" do
          let(:path) { collection_path }
          it "should be routable" do
            expect(post: path).to be_routable
          end
          it "should route correctly" do
            expect(post: path).to route_to( controller: controller, action: "create", user_id: user)
          end
        end
        context "Scrap 1" do
          let(:path) { member_path }
          # SHOW
          context "GET #{member_path}" do
            it "should be routable" do
              expect(get: path).to be_routable
            end
            it "should route correctly" do
              expect(get: path).to route_to(controller: controller, action: "show", user_id: user, id:"1")
            end
          end
          # SHOW
          context "GET #{member_path}/raw" do
            it "should be routable" do
              expect(get: "#{path}/raw").to be_routable
            end
            it "should route correctly" do
              expect(get: "#{path}/raw").to route_to(controller: controller, action: "raw", user_id: user, id:"1")
            end
          end
          # EDIT
          context "GET #{member_path}/edit" do
            it "should be routable" do
              expect(get: "#{path}/edit").to be_routable
            end
            it "should route correctly" do
              expect(get: "#{path}/edit").to route_to(controller: controller, action: "edit", user_id: user, id:"1")
            end
          end
          # UPDATE - PUT
          context "PUT #{member_path}" do
            it "should be routable" do
              expect(put: path).to be_routable
            end
            it "should route correctly" do
              expect(put: path).to route_to(controller:controller, action: "update", user_id: user, id: "1")
            end
          end
          # UPDATE - PATCH
          context "PATCH #{member_path}" do
            it "should be routable" do
              expect(patch: path).to be_routable
            end
            it "should route correctly" do
              expect(patch: path).to route_to(controller:controller, action: "update", user_id: user, id: "1")
            end
          end
          # DESTROY
          context "DELETE #{member_path}" do
            it "should be routable" do
              expect(delete: path).to be_routable
            end
            it "should route correctly" do
              expect(delete: path).to route_to(controller:controller, action: "destroy", user_id: user, id: "1")
            end
          end
        end
      end
    end
  end
end
