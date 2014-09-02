require "rails_helper"

describe Users::Api::ScrapsController do
  let(:controller) { "users/api/scraps" }
  describe "(routes)" do
    # /:user_id/api/*endpoint
    context "(valid route)" do
      Scrap::HTTP_METHODS.each do |m|
        [
          "hello",
          "hello/there",
          "hello/my/darling"
        ].each do |endpoint|
          path = "/FuBaur/api/#{endpoint}"
          context "#{m} #{path}" do
            it "should be routable" do
              expect( "#{m.downcase}" => path ).to be_routable
            end#should be routable
            it "should route correctly" do
              expect( "#{m.downcase}" => path ).to route_to({
                controller: controller,
                action: "show",
                user_id: "FuBaur",
                endpoint: endpoint
              })
            end#should route correctly
          end
        end
      end
    end#(valid route)
    context "(invalid route)" do
      Scrap::HTTP_METHODS.each do |m|
        ["/FuBaur/api/", "/FuBaur/api"].each do |path|
          context "#{m} #{path}" do
            it "should not be routable" do
              expect( "#{m.downcase}" => path ).not_to be_routable
            end
          end
        end
      end
    end#(invalid route)
  end#(routes)
end
