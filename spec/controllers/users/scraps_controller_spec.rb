require "rails_helper"

describe Users::ScrapsController do
  include Devise::TestHelpers

  include_examples "sorting scraps"

  before(:each) do
    @user = FactoryGirl.create(:user)
    @scrap = FactoryGirl.create(:visible_scrap, user: @user)
    FactoryGirl.create_list(:visible_scrap, 1, user: @user)
    FactoryGirl.create_list(:invisible_scrap, 3, user: @user)
    allow(request.env['warden']).to receive(:authenticate!) { @user }
  end

  it { expect(@user.scraps.count).to eq(5) }

  describe "GET #index" do
    before(:each) do
      allow(controller).to receive(:apply_sorting).and_call_original
    end
    let(:get_index) { get :index, user_id: @user }
    it "sets @scraps" do
      get_index
      expect(assigns(:scraps)).to_not be_nil
    end
    it "displays 5 scraps when viewed by owner" do
      allow(controller).to receive(:current_user) { @user }
      get_index
      expect(assigns(:scraps).count).to eq(5)
    end
    it "displays 2 scraps when viewed by another user" do
      allow(controller).to receive(:current_user) { FactoryGirl.create(:user) }
      get_index
      expect(assigns(:scraps).count).to eq(2)
    end
    it "displays 2 scraps when viewed by guest user" do
      allow(controller).to receive(:current_user) { nil }
      get_index
      expect(assigns(:scraps).count).to eq(2)
    end
    it "calls #apply_sorting" do
      get_index
      expect(controller).to have_received(:apply_sorting)
    end
    it "calls #apply_sorting with expected arguments" do
      get_index
      expect(controller).to have_received(:apply_sorting).with(Scrap.visible, nil)
    end
    context "with sorting param" do
      %w[
        created_asc
        created_desc
        updated_asc
        updated_desc
        foobar
      ].each do |sort|
        context "of '#{sort}'" do
          let(:get_sorted_index) { get :index, user_id: @user, sort: sort }
          it "doesn't error" do
            expect{ get_sorted_index }.to_not raise_error
          end
          it "calls apply_sorting with expected arguments" do
            get_sorted_index
            expect(controller).to have_received(:apply_sorting).with(Scrap.visible, sort)
          end
        end
      end
    end#with sorting param
  end#GET #index

  describe "GET #show" do
    context "with existing scrap" do
      it "doesn't error" do
        expect { get :show, user_id: @user, id: @scrap }.to_not raise_error
      end
      context "(post-stress assertions)" do
        before(:each) { get :show, user_id: @user, id: @scrap }
        it "sets @scrap" do
          expect(assigns(:scrap)).to_not be_nil
        end
        it "fetches correct scrap" do
          expect(assigns(:scrap)).to eq(@scrap)
        end
      end
    end
    context "with nonexistent scrap" do
      before(:each) do
        @missing_scrap = FactoryGirl.build(:scrap)
        @missing_scrap.ensure_uid!
      end
      it "doesn't error" do
        expect { get :show, user_id: @user, id: @missing_scrap }.to_not raise_error
      end
      context "(post-stress assertions)" do
        before(:each) { get :show, user_id: @user, id: @missing_scrap }
        it "sets flash alert" do
          expect(flash[:alert]).to eq("Scrap Not Found")
        end
        it "redirects to user scraps" do
          expect(response).to redirect_to( user_scraps_path(@user) )
        end
      end
    end
  end#GET #show

  describe "GET #raw" do
    context "with existing scrap" do
      it "doesn't error" do
        expect { get :raw, user_id: @user, id: @scrap }.to_not raise_error
      end
      context "(post-stress assertions)" do
        before(:each) { get :raw, user_id: @user, id: @scrap }
        it "sets @scrap" do
          expect(assigns(:scrap)).to_not be_nil
        end
        it "fetches correct scrap" do
          expect(assigns(:scrap)).to eq(@scrap)
        end
        it "is successful" do
          expect(response).to be_successful
        end
        it "renders plain text" do
          expect(response.content_type).to eq("text/plain")
        end
        it "renders expected body" do
          expect(response.body).to eq(@scrap.body)
        end
      end
    end
    context "with nonexistent scrap" do
      before(:each) do
        @missing_scrap = FactoryGirl.build(:scrap)
        @missing_scrap.ensure_uid!
      end
      it "doesn't error" do
        expect { get :raw, user_id: @user, id: @missing_scrap }.to_not raise_error
      end
      context "(post-stress assertions)" do
        before(:each) { get :raw, user_id: @user, id: @missing_scrap }
        it "renders plain text" do
          expect(response.content_type).to eq("text/plain")
        end
        it "responds as 404" do
          expect(response.code).to eq("404")
        end
        it "renders expected body" do
          expect(response.body).to eq("Scrap Not Found")
        end
      end
    end
  end#GET #raw

  context "as owner of resource" do
    before(:each) do
      allow(controller).to receive(:current_user) { @user }
    end
    describe "GET #new" do
      subject(:get_new) { get :new, user_id: @user }
      it "doesn't error" do
        expect{get_new}.to_not raise_error
      end
      context "(post-stress assertions)" do
        before(:each) { get_new }
        it "succeeds" do
          expect(response).to be_successful
        end
        it "renders 'new' template" do
          expect(response).to render_template(:new)
        end
      end#post-stress assertions
    end#GET #new
    describe "GET #edit" do
      subject(:get_edit) { get :edit, user_id: @user, id: @scrap }
      it "doesn't error" do
        expect{ get_edit }.to_not raise_error
      end
      context "(post-stress assertions)" do
        before(:each) { get_edit }
        it "succeeds" do
          expect(response).to be_successful
        end
        it "sets @scrap" do
          expect(assigns(:scrap)).to_not be_nil
        end
        it "sets @scrap correctly" do
          expect(assigns(:scrap)).to eq(@scrap)
        end
        it "renders 'edit' template" do
          expect(response).to render_template(:edit)
        end
      end#post-stress assertions
    end#GET #edit
    describe "POST #create" do
      subject(:post_create) { post :create, user_id: @user, scrap: FactoryGirl.attributes_for(:duplicate_scrap) }
      it "doesn't error" do
        expect{ post_create }.to_not raise_error
      end
      it "should increase scrap count by 1" do
        expect { post_create }.to change(Scrap,:count).by(1)
      end
      context "with valid attributes" do
        before(:each) do
          post_create
        end
        it "sets flash notice" do
          expect(flash[:notice]).to eq("Scrap Saved")
        end
        it "redirects to user_scrap_path" do
          # TODO: how to do this with custom primary_key that is generated before validation
          # Not sure how to get the :uid of the created scrap
          #expect(response).to redirect_to(user_scrap_path(@user, @scrap))
        end
      end#valid attributes
      context "with invalid attributes" do
        before(:each) do
          bad_attrs = FactoryGirl.attributes_for(:duplicate_scrap)
          bad_attrs.delete(:endpoint)
          post :create, user_id: @user, scrap: bad_attrs
        end
        it "sets flash alert" do
          expect(flash.now[:alert]).to match(/Scrap Could not be Saved/)
        end
        it "renders :new" do
          expect(response).to render_template(:new)
        end
      end#invalid attributes
    end#POST #create
    describe "PATCH #update" do
      subject(:patch_update) { patch :update, user_id: @user, id: @scrap, scrap: FactoryGirl.attributes_for(:scrap) }
      it "doesn't error" do
        expect{ patch_update }.to_not raise_error
      end
      context "with successful update_attributes" do
        before(:each) do
          allow_any_instance_of(Scrap).to receive(:update_attributes).and_return(true)
          patch_update
        end
        it "sets flash notice" do
          expect(flash[:notice]).to eq("Scrap Updated")
        end
        it "redirects to user_scrap_path" do
          expect(response).to redirect_to(user_scrap_path(@user, @scrap))
        end
      end#valid attributes
      context "with unsuccessful update_attributes" do
        before(:each) do
          allow_any_instance_of(Scrap).to receive(:update_attributes).and_return(false)
          patch_update
        end
        it "sets flash alert" do
          expect(flash.now[:alert]).to match(/Scrap Could not be updated/)
        end
        it "renders :edit" do
          expect(response).to render_template(:edit)
        end
      end#invalid attributes
    end#PATCH #update
    describe "DELETE #destroy" do
      subject(:delete_destroy) { delete :destroy, user_id: @user, id: @scrap }
      it "doesn't error" do
        expect{ delete_destroy }.to_not raise_error
      end
      context "with successful destroy" do
        before(:each) do
          allow_any_instance_of(Scrap).to receive(:destroy).and_return(true)
          delete_destroy
        end
        it "sets flash notice" do
          expect(flash[:notice]).to eq("Scrap destroyed")
        end
        it "redirects to user scraps path" do
          expect(response).to redirect_to(user_scraps_path(@user))
        end
      end
      context "with unsuccessful destroy" do
        before(:each) do
          allow_any_instance_of(Scrap).to receive(:destroy).and_return(false)
          delete_destroy
        end
        it "sets flash alert" do
          expect(flash[:alert]).to eq("Could not destroy scrap")
        end
        it "redirects to user scrap path" do
          expect(response).to redirect_to(user_scrap_path(@user, @scrap))
        end
      end
    end#DELETE #destroy
  end#owner of resource

  context "as non-owner of resource" do
    {
      "authenticated" => :user,
      "guest" => nil
    }.each do |ilk, fg_klass|
      context "(#{ilk} user)" do
        before(:each) do
          @given_user = fg_klass.nil? ? nil : FactoryGirl.build(fg_klass)
          allow(controller).to receive(:current_user) { @given_user }
        end
        describe "GET #new" do
          subject(:get_new) { get :new, user_id: @user }
          it "doesn't error" do
            expect { get_new }.to_not raise_error
          end
          context "(post-stress assertions)" do
            before(:each) { get_new }
            it "is unsuccessful" do
              expect(response).to_not be_successful
            end
            it "redirects to user_scraps path" do
              expect(response).to redirect_to( user_scraps_path(@user) )
            end
            it "sets flash" do
              expect(flash[:alert]).to_not be_nil
            end
            it "sets flash to expected" do
              # TODO: abstract this message elsewhere
              expect(flash[:alert]).to eq(UsersController::UNAUTHORIZED_MESSAGE)
            end
          end
        end#GET #new
        describe "GET #edit" do
          subject(:get_edit) { get :edit, user_id: @user, id: @scrap }
          it "doesn't error" do
            expect{ get_edit }.to_not raise_error
          end
          context "(post-stress assertions)" do
            before(:each) { get_edit }
            it "redirects to user_scraps path" do
              expect(response).to redirect_to( user_scraps_path(@user) )
            end
            it "sets flash" do
              expect(flash[:alert]).to_not be_nil
            end
            it "sets flash to expected" do
              # TODO: abstract this message elsewhere
              expect(flash[:alert]).to eq(UsersController::UNAUTHORIZED_MESSAGE)
            end
          end#post-stress assertions
        end#GET #edit
        describe "POST #create" do
          subject(:post_create) { post :create, user_id: @user, scrap: { foo: "bar" } }
          it "doesn't error" do
            expect{ post_create }.to_not raise_error
          end
          context "(post-stress assertions)" do
            before(:each) { post_create }
            it "redirects to user_scraps path" do
              expect(response).to redirect_to( user_scraps_path(@user) )
            end
            it "sets flash" do
              expect(flash[:alert]).to_not be_nil
            end
            it "sets flash to expected" do
              # TODO: abstract this message elsewhere
              expect(flash[:alert]).to eq(UsersController::UNAUTHORIZED_MESSAGE)
            end
          end#post-stress assertions
        end#POST #create
        describe "PATCH #update" do
          subject(:patch_update) { patch :update, user_id: @user, id: @scrap, scrap: { foo: "bar" } }
          it "doesn't error" do
            expect{ patch_update }.to_not raise_error
          end
          context "(post-stress assertions)" do
            before(:each) { patch_update }
            it "redirects to user_scraps path" do
              expect(response).to redirect_to( user_scraps_path(@user) )
            end
            it "sets flash" do
              expect(flash[:alert]).to_not be_nil
            end
            it "sets flash to expected" do
              # TODO: abstract this message elsewhere
              expect(flash[:alert]).to eq(UsersController::UNAUTHORIZED_MESSAGE)
            end
          end#post-stress assertions
        end#PATCH #update
        describe "DELETE #destroy" do
          subject(:delete_destroy) { delete :destroy, user_id: @user, id: @scrap }
          it "doesn't error" do
            expect{ delete_destroy }.to_not raise_error
          end
          context "(post-stress assertions)" do
            before(:each) { delete_destroy }
            it "redirects to user_scraps path" do
              expect(response).to redirect_to( user_scraps_path(@user) )
            end
            it "sets flash" do
              expect(flash[:alert]).to_not be_nil
            end
            it "sets flash to expected" do
              # TODO: abstract this message elsewhere
              expect(flash[:alert]).to eq(UsersController::UNAUTHORIZED_MESSAGE)
            end
          end#post-stress assertions
        end#DELETE #destroy
      end
    end
  end#as non-owner of resource

  describe "#scrap_attributes" do
    it "responds" do
      expect(controller).to respond_to(:scrap_attributes)
    end
  end
end
