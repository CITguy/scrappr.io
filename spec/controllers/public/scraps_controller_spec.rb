require "rails_helper"

describe Public::ScrapsController do
  include_examples "sorting scraps"

  describe "#index" do
    before(:each) do
      allow(controller).to receive(:apply_sorting).and_call_original
    end
    let(:get_index) { get :index }
    context "(post-stress assertions)" do
      before(:each) { get_index }
      it "is successful" do
        expect(response).to be_successful
      end
      it "assigns @scraps" do
        expect(assigns(:scraps)).to_not be_nil
      end
      it "calls #apply_sorting" do
        expect(controller).to have_received(:apply_sorting)
      end
      it "calls #apply_sorting with expected arguments" do
        expect(controller).to have_received(:apply_sorting).with(Scrap.visible, nil)
      end
    end#(post-stress assertions)
    context "with sorting param" do
      %w[
        created_asc
        created_desc
        updated_asc
        updated_desc
        foobar
      ].each do |sort|
        context "of '#{sort}'" do
          let(:get_index) { get :index, sort: sort }
          it "doesn't error" do
            expect{ get_index }.to_not raise_error
          end
          it "calls #apply_sorting with expected arguments" do
            get_index
            expect(controller).to have_received(:apply_sorting).with(Scrap.visible, sort)
          end
        end
      end
    end#with sorting param
    context "with existing scraps" do
      before(:each) { FactoryGirl.create_list(:scrap, 12) }
      it "retrieves a max of 10 results" do
        get_index
        expect(assigns(:scraps).count).to be <= 10
      end
    end#with existing scraps
  end#index
end
