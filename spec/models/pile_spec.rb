# == Schema Information
#
# Table name: piles
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :text
#  protected   :boolean          default(FALSE), not null
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

describe Pile do
  subject { Pile }
  describe ".from_param" do
    before(:each) do
      allow(subject).to receive(:where).and_return(true)
    end
    it "should filter by proper values" do
      subject.from_param("foobar")
      expect(subject).to have_received(:where).with({ name: "foobar" })
    end
  end

  context "(instance)" do
    subject { FactoryGirl.build(:pile) }
    it { expect(subject).to be_valid }
    context "(validations)" do
      context "name" do
        it "should not be valid if nil" do
          subject.name = nil
          expect(subject).not_to be_valid
        end
        it "should not be valid if blank" do
          subject.name = ""
          expect(subject).not_to be_valid
        end
        it "should be valid if unique value" do
          subject.name = "Sir Fluffy Longbottom"
          expect(subject).to be_valid
        end
        context "if duplicate" do
          let(:dupe_pile) { FactoryGirl.create(:pile) }
          before(:each) { subject.name = dupe_pile.name }
          context "for same user" do
            before(:each) { subject.user = dupe_pile.user }
            it { expect(subject).not_to be_valid }
          end
          context "for different user" do
            before(:each) { subject.user = FactoryGirl.build(:user) }
            it { expect(subject).to be_valid }
          end
        end
      end
      context "user" do
        it "should not be valid without a user" do
          subject.user = nil
          expect(subject).not_to be_valid
        end
        it "should be valid with a user" do
          subject.user = FactoryGirl.build(:user)
          expect(subject).to be_valid
        end
      end
    end
    describe "#to_param" do
      it "should equal parameterized name" do
        expected = subject.name.parameterize
        expect(subject.to_param).to eq(expected)
      end
    end##to_param
    describe "#user" do
      it { expect(subject).to respond_to(:user) }
    end##user
    describe "#scraps" do
      it { expect(subject).to respond_to(:scraps) }
    end
  end
end
