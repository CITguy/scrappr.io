# == Schema Information
#
# Table name: content_types
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#

require 'rails_helper'

describe ContentType do
  subject { ContentType }
  before(:each) { FactoryGirl.create(:content_type) }
  context "(instance)" do
    subject { FactoryGirl.build(:content_type) }
    it { expect(subject).to be_valid }
    context "name" do
      it "should not be valid if nil" do
        subject.name = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if empty" do
        subject.name = ""
        expect(subject).to_not be_valid
      end
      context "(when duplicate)" do
        before(:each) { FactoryGirl.create(:duplicate_name_content_type) }
        subject { FactoryGirl.build(:duplicate_name_content_type) }
        it "should not be valid" do
          expect(subject).to_not be_valid
        end
      end
    end
  end
end
