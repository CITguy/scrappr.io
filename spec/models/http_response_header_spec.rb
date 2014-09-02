# == Schema Information
#
# Table name: http_response_headers
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  status      :string(255)      default("nonstandard"), not null
#  description :text
#

require 'rails_helper'

describe HttpResponseHeader do
  subject { HttpResponseHeader }
  before(:each) { @header_1 = FactoryGirl.create(:http_response_header) }

  context "(class)" do
    context ".options_for_select" do
      it "should respond" do
        expect(subject).to respond_to(:options_for_select)
      end
      it "should return an Array" do
        expect(subject.options_for_select).to be_a_kind_of(Array)
      end
      context "(with existing data)" do
        before(:each) do
          @header_2 = FactoryGirl.create(:http_response_header)
          @header_3 = FactoryGirl.create(:http_response_header)
        end
        it "should return 3 results" do
          expect(subject.options_for_select.size).to eq(3)
        end
        it "should return expected" do
          expected = [@header_1.name, @header_2.name, @header_3.name]
          expect(subject.options_for_select).to eq(expected)
        end
      end
    end
    context "VALID_STATUSES" do
      it "should have VALID_STATUSES constant" do
        expect(subject.constants).to include(:VALID_STATUSES)
      end
      it "should be an Array" do
        expect(subject::VALID_STATUSES).to be_a_kind_of(Array)
      end
      it "should be frozen" do
        expect(subject::VALID_STATUSES).to be_frozen
      end
    end
  end#(class)

  context "(instance)" do
    subject { FactoryGirl.build(:http_response_header) }
    it "should be valid from FactoryGirl" do
      expect(subject).to be_valid
    end
    context "name" do
      it "should not be valid if nil" do
        subject.name = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.name = ""
        expect(subject).to_not be_valid
      end
      context "when duplicate" do
        before(:each) { FactoryGirl.create(:dupe_name_http_response_header) }
        subject { FactoryGirl.build(:dupe_name_http_response_header) }
        it "should not be valid" do
          expect(subject).to_not be_valid
        end
      end
    end#name
    context "status" do
      it "should not be valid if nil" do
        subject.status = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.status = ""
        expect(subject).to_not be_valid
      end
      context "(acceptable value)" do
        HttpResponseHeader::VALID_STATUSES.each do |status|
          it "should be valid if status is '#{status}'" do
            subject.status = status
            expect(subject).to be_valid
          end
        end
      end
      context "(unacceptable value)" do
        nope_val = "totally_unacceptable_value"
        it "should not be valid if '#{nope_val}'" do
          subject.status = nope_val
          expect(subject).to_not be_valid
        end
      end
    end#status
  end#(instance)
end
