require "rails_helper"

describe PublicController do
  let(:controller) { "public" }

  describe "(routes)" do
    [
      "/FooBar/api/biz",
      "/BangBiz/api/fiz/buzz"
    ].each do |path|
      describe "GET #{path}" do
        it "should be routable" do
          expect(get: "#{path}").to be_routable
        end
      end
      describe "OPTIONS #{path}" do
        it "should be routable" do
          expect(options: "#{path}").to be_routable
        end
      end
    end
  end
end
