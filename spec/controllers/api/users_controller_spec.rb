require 'rails_helper'
require 'ostruct'

describe Api::UsersController do
  before(:each) do
    allow(controller).to receive(:broken_update).and_call_original
    allow(controller).to receive(:unknown_theme).and_call_original
    allow(controller).to receive(:remembered).and_call_original
  end

  describe "#update" do
    context "for nonexistent user" do
      let(:theme) { FactoryGirl.create(:editor_theme) }
      let(:user) { FactoryGirl.build(:user) }
      before(:each) { patch :update, id: user.username, theme: theme.ace_id }
      it "is unsuccessful" do
        expect(response).to_not be_successful
      end
      it "calls #broken_update" do
        expect(controller).to have_received(:broken_update)
      end
      it "calls #broken_update with expected arguments" do
        expect(controller).to have_received(:broken_update).with("Unknown User")
      end
    end#nonexistent user
    context "for existing user" do
      let(:user) { FactoryGirl.create(:user) }
      context "with valid theme" do
        let(:theme) { FactoryGirl.create(:editor_theme) }
        before(:each) { patch :update, id: user.to_param, theme: theme.ace_id }
        it "is successful" do
          expect(response).to be_successful
        end
        it "calls #remembered" do
          expect(controller).to have_received(:remembered)
        end
        it "calls #remembered with expected arguments" do
          expect(controller).to have_received(:remembered).with(theme.ace_id)
        end
        context "broken user.update" do
          before(:each) do
            @user = FactoryGirl.create(:user)
            user_errors = OpenStruct.new(full_messages: "done broke")
            allow(@user).to receive(:errors).and_return(user_errors)
            allow(@user).to receive(:update).and_return(false)
            allow(User).to receive(:find_by!).and_return(@user)

            patch :update, id: @user.username, theme: theme.ace_id
          end
          it "is unsuccessful" do
            expect(response).to_not be_successful
          end
          it "calls #broken_update" do
            expect(controller).to have_received(:broken_update)
          end
          it "calls #broken_update with expected params" do
            expect(controller).to have_received(:broken_update).with("done broke")
          end
        end#broken user.update
      end#valid theme
      context "with invalid theme" do
        let(:theme) { FactoryGirl.build(:editor_theme) }
        before(:each) { patch :update, id: user.username, theme: theme.ace_id }
        it "is unsuccessful" do
          expect(response).to_not be_successful
        end
        it "calls #unknown_theme" do
          expect(controller).to have_received(:unknown_theme)
        end
        it "calls #unknown_theme with expected arguments" do
          expect(controller).to have_received(:unknown_theme).with(theme.ace_id)
        end
      end#invalid theme
    end#existing user
  end#update

  describe "#remembered" do
    let(:theme) { FactoryGirl.build(:editor_theme) }
    it "responds" do
      expect(controller).to respond_to(:remembered)
    end
    it "returns Hash" do
      expect(controller.remembered(theme.ace_id)).to be_a_kind_of(Hash)
    end
    it "returns expected Hash" do
      arg = theme.ace_id
      expected = {
        status: 200,
        json: { message: "Remembered Theme '#{arg}'" }.to_json
      }
      expect(controller.remembered(arg)).to eq(expected)
    end
  end#remembered
  describe "#unknown_theme" do
    let(:theme) { "foobar" }
    it "responds" do
      expect(controller).to respond_to(:unknown_theme)
    end
    it "calls #broken_update" do
      controller.unknown_theme(theme)
      expect(controller).to have_received(:broken_update)
    end
    it "calls #broken_update with expected arguments" do
      controller.unknown_theme(theme)
      args = "Unknown Theme '#{theme}'"
      expect(controller).to have_received(:broken_update).with(args)
    end
  end#unknown_theme
  describe "#broken_update" do
    let(:errs) { "done broke" }
    it "responds" do
      expect(controller).to respond_to(:broken_update)
    end
    it "returns Hash" do
      expect(controller.broken_update(errs)).to be_a_kind_of(Hash)
    end
    it "returns expected Hash" do
      expected = {
        status: 500,
        json: { message: "Cannot Remember Theme", errors: errs }.to_json
      }
      expect(controller.broken_update(errs)).to eq(expected)
    end
  end#broken_update
end
