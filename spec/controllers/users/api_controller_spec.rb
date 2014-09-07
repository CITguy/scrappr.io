require "rails_helper"

describe Users::ApiController do
  describe "before_action" do
    context ":fetch_user" do
      controller do
        def index
          render json: { good: "show" }
        end
      end#controller
      before(:each) do
        allow(controller).to receive(:fetch_user)
        get :index, user_id: "nobody"
      end
      it "calls #fetch_user" do
        expect(controller).to have_received(:fetch_user)
      end
      it "calls #fetch_user with expected arguments" do
        expect(controller).to have_received(:fetch_user).with("nobody")
      end
    end#:fetch_user
  end#before_action
  describe "#fetch_user" do
    let(:user) { FactoryGirl.create(:user) }
    it "responds" do
      expect(controller).to respond_to(:fetch_user)
    end
    it "expects 1 argument" do
      expect(controller.method(:fetch_user).arity).to eq(1)
    end
    it "errors when called without arguments" do
      expect { controller.fetch_user }.to raise_error
    end
    context "(user exists)" do
      before(:each) { controller.params[:user_id] = user.username }
      it "sets @user" do
        controller.fetch_user(user.username)
        expect(assigns(:user)).to_not be_nil
      end
    end#(user exists)
    context "(user doesn't exist)" do
      let(:user) { FactoryGirl.build(:user) }
      before(:each) { allow(controller).to receive(:invalid_path) }
      it "doesn't error" do
        expect { controller.fetch_user(user.username) }.to_not raise_error
      end
      it "calls #invalid_path" do
        controller.fetch_user(user.username)
        expect(controller).to have_received(:invalid_path)
      end
      it "calls #invalid_path with expected arguments" do
        controller.fetch_user(user.username)
        expect(controller).to have_received(:invalid_path).with("Path")
      end
    end
  end#fetch_user
  describe "#invalid_path" do
    it "responds" do
      expect(controller).to respond_to(:invalid_path)
    end
    it "expects 1 argument" do
      expect(controller.method(:invalid_path).arity).to eq(1)
    end
    it "errors when called without arguments" do
      expect { controller.invalid_path }.to raise_error
    end
    context "from controller method" do
      controller do
        def index
          invalid_path("Foobar")
        end
      end
      before(:each) do
        allow(controller).to receive(:fetch_user)
        get :index
      end
      it "is unsuccessful" do
        expect(response).to_not be_successful
      end
      it "renders plain text" do
        expect( response.content_type ).to eq("text/plain")
      end
      it "responds as 404" do
        expect( response.code ).to eq("404")
      end
      it "responds with expect content" do
        expect(response.body).to eq("Unknown Foobar")
      end
    end
  end#invalid_path
end
