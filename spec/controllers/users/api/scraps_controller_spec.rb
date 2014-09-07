require "rails_helper"

describe Users::Api::ScrapsController do
  render_views

  Scrap::HTTP_METHODS.each do |m|
    describe "#{m} #show" do
      context "when matching scrap exists" do
        before(:each) do
          @headers = response.headers
          allow(@headers).to receive(:merge!).and_call_original
          allow(response).to receive(:headers).and_return(@headers)
        end

        before(:each) do
          @scrap = FactoryGirl.create(:scrap, http_method: m)
          send_method = "#{m}".downcase
          send_params = { user_id: @scrap.user.username, endpoint: @scrap.endpoint }

          send(send_method, :show, send_params)
        end

        it "sets @scrap" do
          expect(assigns(:scrap)).to_not be_nil
        end
        it "calls #merge! on response.headers" do
          expect(@headers).to have_received(:merge!).with(@scrap.http_headers)
        end
        it "renders expected code" do
          expect(response.code).to eq(@scrap.status_code.to_s)
        end
        it "renders expected body" do
          expect(response.body).to eq(@scrap.body)
        end
        it "renders expected content_type" do
          expect(response.content_type).to eq(@scrap.content_type)
        end
      end
      context "when no matching scraps exist" do
        before(:each) do
          allow(controller).to receive(:invalid_path).and_call_original
          Scrap.destroy_all
          send_method = "#{m}".downcase
          scrap = FactoryGirl.build(:scrap)
          send(send_method, :show, { user_id: scrap.user.username, endpoint: scrap.endpoint })
        end
        it "calls #invalid_path with expected argument" do
          expect(controller).to have_received(:invalid_path).with("Endpoint")
        end
      end
    end#<verb> #show
  end#Scrap::HTTP_METHODS
end
