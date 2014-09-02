# == Schema Information
#
# Table name: status_codes
#
#  id          :integer          not null, primary key
#  number      :integer          not null
#  desc        :string(255)      not null
#  is_standard :boolean          default(FALSE), not null
#  rfc         :string(255)
#

require 'rails_helper'

describe StatusCode do
  subject { StatusCode }

  context "(class)" do
    context ".options_for_select" do
      it "should respond" do
        expect(subject).to respond_to(:options_for_select)
      end
      it "should return array" do
        expect(subject.options_for_select).to be_a_kind_of(Array)
      end
      context "(with existing data)" do
        before(:each) do
          @status_code1 = FactoryGirl.create(:status_code)
          @status_code2 = FactoryGirl.create(:status_code)
        end
        it "should return expected" do
          expected = [
            [@status_code1.option_text, @status_code1.number],
            [@status_code2.option_text, @status_code2.number]
          ]
          expect(subject.options_for_select).to eq(expected)
        end
      end
    end#.options_for_select
  end#(class)

  context "(instance)" do
    before(:each) { @status_code_1 = FactoryGirl.create(:status_code) }
    subject { FactoryGirl.build(:status_code) }
    it "should be valid from FactoryGirl" do
      expect(subject).to be_valid
    end
    context ".number" do
      it "should respond" do
        expect(subject).to respond_to(:number)
      end
      it "should not be valid if nil" do
        subject.number = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.number = nil
        expect(subject).to_not be_valid
      end
    end#number
    context ".desc" do
      it "should respond" do
        expect(subject).to respond_to(:desc)
      end
      it "should not be valid if nil" do
        subject.desc = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.desc = ""
        expect(subject).to_not be_valid
      end
    end#desc
    context ".is_standard" do
      it "should respond" do
        expect(subject).to respond_to(:is_standard)
      end
      it "should not be valid if nil" do
        subject.is_standard = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.is_standard = ""
        expect(subject).to_not be_valid
      end
    end#is_standard
    context "#option_text" do
      it "should respond" do
        expect(subject).to respond_to(:option_text)
      end
      it "should return expected" do
        expect(subject.option_text).to eq("#{subject.number} - #{subject.desc}")
      end
    end#option_text

    context "(when duplicate)" do
      before(:each) { @dupe_status_code = FactoryGirl.create(:dupe_status_code) }
      subject { FactoryGirl.build(:status_code) }
      context "(duplicate number)" do
        before(:each) do
          subject.number = @dupe_status_code.number
        end
        context "(duplicate description)" do
          before(:each) do
            subject.desc = @dupe_status_code.desc
          end
          it "should not be valid" do
            expect(subject).to_not be_valid
          end
        end
        context "(unique description)" do
          it "should be valid" do
            expect(subject).to be_valid
          end
        end
      end
    end
  end#(instance)
end
