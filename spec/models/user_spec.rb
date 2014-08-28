# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  remember_created_at :datetime
#  provider            :string(255)      not null
#  uid                 :string(255)      not null
#  username            :string(255)      not null
#  created_at          :datetime
#  updated_at          :datetime
#

require 'rails_helper'

describe User do
  subject { User }

  describe ".from_omniauth" do
    it "should respond to :from_omniauth" do
      expect(subject).to respond_to(:from_omniauth)
    end
  end#.from_omniauth
  describe ".from_param" do
    before(:each) do
      allow(subject).to receive(:where).and_return(true)
    end
    it "should filter by proper values" do
      subject.from_param("foobar")
      expect(subject).to have_received(:where).with({username: "foobar"})
    end
  end#.from_param

  context "(instance)" do
    subject { FactoryGirl.build(:user) }
    it { expect(subject).to be_valid }
    context "username" do
      it "should not be valid if nil" do
        subject.username = nil
        expect(subject).not_to be_valid
      end
      it "should not be valid if blank" do
        subject.username = ""
        expect(subject).not_to be_valid
      end
      context "(duplicate)" do
        before(:each) do
          @dupe = FactoryGirl.create(:user)
        end
        it "should not be valid if duplicated" do
          subject.username = @dupe.username
          expect(subject).not_to be_valid
        end
      end
    end
    describe "#to_param" do
      it "should equal #username" do
        expect(subject.to_param).to eq(subject.username)
      end
    end##to_param
    describe "#scraps" do
      it { expect(subject).to respond_to(:scraps) }
    end
  end#(instance)
end
