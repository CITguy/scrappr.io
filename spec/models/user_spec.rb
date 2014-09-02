# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  remember_created_at :datetime
#  provider            :string(255)      not null
#  uid                 :string(255)      not null
#  username            :string(255)      not null
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :string(255)
#  last_sign_in_ip     :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  theme_id            :integer          default(1)
#

require 'rails_helper'
require 'cancan/matchers'

describe User do
  subject { User }

  describe "(class)" do
    context ".from_omniauth" do
      let(:fake_auth) do
        ah = OmniAuth::AuthHash.new
        ah.provider = "github"
        ah.uid = "12345"
        ah.info = OmniAuth::AuthHash.new
        ah.info.nickname = "nickname123"
        ah
      end#:fake_auth
      it "should respond" do
        expect(subject).to respond_to(:from_omniauth)
      end
      it "should call .where with proper variables" do
        arb = ActiveRecord::Base
        allow(arb).to receive(:first_or_create).and_yield(User.new)
        allow(subject).to receive(:where).and_return(arb)

        subject.from_omniauth(fake_auth)
        expect(subject).to have_received(:where).with({:provider => "github", :uid => "12345"})
      end
      it "should create a user" do
        expect(subject.count).to eq(0)
        subject.from_omniauth(fake_auth)
        expect(subject.count).to eq(1)
      end
      it "should return a User" do
        expect(subject.from_omniauth(fake_auth)).to be_a_kind_of(User)
      end
      context "(response)" do
        let(:response) { subject.from_omniauth(fake_auth) }
        it "should have proper provider" do
          expect(response.provider).to eq("github")
        end
        it "should have proper uid" do
          expect(response.uid).to eq('12345')
        end
        it "should have proper username" do
          expect(response.username).to eq('nickname123')
        end
      end
    end#.from_omniauth
    context ".from_param" do
      it "should respond" do
        expect(subject).to respond_to(:from_param)
      end
      it "should return an ActiveRelation object" do
        user = FactoryGirl.create(:user)
        expect(subject.from_param(user.username)).to be_a_kind_of(ActiveRecord::Relation)
      end
      it "should call #where" do
        allow(subject).to receive(:where)
        subject.from_param("foobar")
        expect(subject).to have_received(:where)
      end
      it "should call #where with expected arguments" do
        allow(subject).to receive(:where)
        subject.from_param("foobar")
        expect(subject).to have_received(:where).with({:username => "foobar"})
      end
    end#.from_param
  end#(class)

  describe "(instance)" do
    subject { FactoryGirl.build(:user) }
    it "should be valid from FactoryGirl" do
      expect(subject).to be_valid
    end
    context "(devise)" do
      context "(rememberable)" do
        context "#remember_created_at" do
          it "should respond" do
            expect(subject).to respond_to(:remember_created_at)
          end
        end#remember_created_at
      end#(rememberable)
      context "(trackable)" do
        context "#sign_in_count" do
          it "should respond" do
            expect(subject).to respond_to(:sign_in_count)
          end
        end#sign_in_count
        context "#current_sign_in_at" do
          it "should respond" do
            expect(subject).to respond_to(:current_sign_in_at)
          end
        end#current_sign_in_at
        context "#last_sign_in_at" do
          it "should respond" do
            expect(subject).to respond_to(:last_sign_in_at)
          end
        end#last_sign_in_at
        context "#current_sign_in_ip" do
          it "should respond" do
            expect(subject).to respond_to(:current_sign_in_ip)
          end
        end#current_sign_in_ip
        context "#last_sign_in_ip" do
          it "should respond" do
            expect(subject).to respond_to(:last_sign_in_ip)
          end
        end#last_sign_in_ip
      end#(trackable)
    end#(devise)
    context "#provider" do
      it "should respond" do
        expect(subject).to respond_to(:provider)
      end
      it "should not be valid if nil" do
        subject.provider = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.provider = ""
        expect(subject).to_not be_valid
      end
    end#provider
    context "#uid" do
      it "should respond" do
        expect(subject).to respond_to(:uid)
      end
      it "should not be valid if nil" do
        subject.uid = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.uid = ""
        expect(subject).to_not be_valid
      end
    end#uid
    context "#username" do
      it "should respond" do
        expect(subject).to respond_to(:username)
      end
      it "should not be valid if nil" do
        subject.username = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.username = ""
        expect(subject).to_not be_valid
      end
      context "(dupe/unique)" do
        before(:each) { FactoryGirl.create(:duplicate_user) }
        context "(duplicate)" do
          subject { FactoryGirl.build(:duplicate_user) }
          it "should not be valid" do
            expect(subject).to_not be_valid
          end
        end
        context "(unique)" do
          subject { FactoryGirl.build(:user) }
          it "should be valid" do
            expect(subject).to be_valid
          end
        end
      end#(dupe/unique)
    end#username
    context "#to_param" do
      it "should respond" do
        expect(subject).to respond_to(:to_param)
      end
      it "should equal #username" do
        expect(subject.to_param).to eq(subject.username)
      end
    end#to_param
    context "#scraps" do
      it "should respond" do
        expect(subject).to respond_to(:scraps)
      end
      it "should return an ActiveRecord::Relation" do
        expect(subject.scraps).to be_a_kind_of(ActiveRecord::Relation)
      end
    end#scraps
    context "#avatar_url" do
      it "should respond" do
        expect(subject).to respond_to(:avatar_url)
      end
      it "should return a String" do
        expect(subject.avatar_url).to be_a_kind_of(String)
      end
      it "should return expected" do
        expect(subject.avatar_url).to eq("https://avatars.githubusercontent.com/u/12345?v=2")
      end
    end#avatar_url
    context "#theme" do
      it "should respond" do
        expect(subject).to respond_to(:theme)
      end
      it "should be an EditorTheme" do
        expect(subject.theme).to be_a_kind_of(EditorTheme)
      end
    end
  end#(instance)

  describe "(abilities)" do
    subject(:ability) { Ability.new(user) }
    context "as a Guest" do
      let(:user) { nil }
      it "should be able to read a Scrap" do
        expect(ability).to be_able_to(:read, Scrap)
      end
      it "should not be able to create a Scrap" do
        expect(ability).to_not be_able_to(:create, Scrap)
      end
      it "should not be able to modify a Scrap" do
        expect(ability).to_not be_able_to(:modify, Scrap)
      end
    end#guest user
    context "as an Authenticated User" do
      let(:user) { FactoryGirl.build_stubbed(:user) }
      it "should be able to read a Scrap" do
        expect(ability).to be_able_to(:read, Scrap)
      end
      it "should be able to create a Scrap" do
        expect(ability).to_not be_able_to(:create, Scrap)
      end
      context "for scraps they own" do
        let(:scrap) { FactoryGirl.build(:scrap, user: user) }
        it "should be able to update the scrap" do
          expect(ability).to be_able_to(:update, scrap)
        end
        it "should be able to destroy the scrap" do
          expect(ability).to be_able_to(:destroy, scrap)
        end
      end
      context "for scraps they do not own" do
        let(:scrap) { FactoryGirl.build(:scrap) }
        it "should not be able to update the scrap" do
          expect(ability).to_not be_able_to(:update, scrap)
        end
        it "should not be able to destroy the scrap" do
          expect(ability).to_not be_able_to(:destroy, scrap)
        end
      end
    end
  end#(abilities)
end
