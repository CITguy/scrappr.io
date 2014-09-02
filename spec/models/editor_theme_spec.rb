# == Schema Information
#
# Table name: editor_themes
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  ilk        :string(255)      default("light"), not null
#  is_enabled :boolean          default(TRUE), not null
#  ace_id     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe EditorTheme do
  subject { EditorTheme }

  context "(class)" do
    context ".grouped_options_for_select" do
      it "should respond" do
        expect(subject).to respond_to(:grouped_options_for_select)
      end
      it "should return an array" do
        expect(subject.grouped_options_for_select).to be_a_kind_of(Array)
      end
    end
    context ".enabled" do
      it "should respond" do
        expect(subject).to respond_to(:enabled)
      end
    end#.enabled
    context ".disabled" do
      it "should respond" do
        expect(subject).to respond_to(:disabled)
      end
    end#.disabled
    context ".light" do
      it "should respond" do
        expect(subject).to respond_to(:light)
      end
    end#.light
    context ".dark" do
      it "should respond" do
        expect(subject).to respond_to(:dark)
      end
    end#.dark
    context "(with existing data)" do
      before(:each) do
        FactoryGirl.create(:light_editor_theme, name: "Enabled Light", is_enabled: true, ace_id: "enabled_light")
        FactoryGirl.create(:light_editor_theme, name: "Disabled Light", is_enabled: false, ace_id: "disabled_light")
        FactoryGirl.create(:dark_editor_theme, name: "Enabled Dark", is_enabled: true, ace_id: "enabled_dark")
        FactoryGirl.create(:dark_editor_theme, name: "Disabled Dark", is_enabled: false, ace_id: "disabled_dark")
      end
      context ".light" do
        it "should count 2 results" do
          expect(subject.light.count).to eq(2)
        end
      end#.light
      context ".dark" do
        it "should count 2 results" do
          expect(subject.dark.count).to eq(2)
        end
      end#.dark
      context ".enabled" do
        it "should count 2 results" do
          expect(subject.enabled.count).to eq(2)
        end
        context ".light" do
          it "should count 1 result" do
            expect(subject.enabled.light.count).to eq(1)
          end
        end#.enabled.light
        context ".dark" do
          it "should count 1 result" do
            expect(subject.enabled.dark.count).to eq(1)
          end
        end#.enabled.dark
      end#.enabled
      context ".disabled" do
        it "should count 2 results" do
          expect(subject.disabled.count).to eq(2)
        end
        context ".light" do
          it "should count 1 result" do
            expect(subject.disabled.light.count).to eq(1)
          end
        end#.disabled.light
        context ".dark" do
          it "should count 1 result" do
            expect(subject.disabled.dark.count).to eq(1)
          end
        end#.disabled.dark
      end#.disabled
      context ".grouped_options_for_select" do
        it "should return enabled themes grouped by ilk" do
          output = [
            ["Light", [ ["Enabled Light", "enabled_light"] ]],
            ["Dark",  [ ["Enabled Dark",  "enabled_dark"]  ]]
          ]
          expect(subject.grouped_options_for_select).to eq(output)
        end
      end#.grouped_options_for_select
    end#(with existing data)
  end#(class)

  context "(instance)" do
    before(:each) { FactoryGirl.create(:editor_theme) }
    subject { FactoryGirl.build(:editor_theme) }
    it "should be valid from FactoryGirl" do
      expect(subject).to be_valid
    end
    context "#name" do
      it "should respond" do
        expect(subject).to respond_to(:name)
      end
      it "should not be valid if nil" do
        subject.name = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.name = ""
        expect(subject).to_not be_valid
      end
    end#name
    context "#ilk" do
      it "should respond" do
        expect(subject).to respond_to(:ilk)
      end
      it "should not be valid if nil" do
        subject.ilk = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.ilk = ""
        expect(subject).to_not be_valid
      end
      it "should be valid if 'light'" do
        subject.ilk = "light"
        expect(subject).to be_valid
      end
      it "should be valid if 'dark'" do
        subject.ilk = "dark"
        expect(subject).to be_valid
      end
      it "should not be valid if 'bw'" do
        subject.ilk = "bw"
        expect(subject).to_not be_valid
      end
    end#ilk
    context "#is_enabled" do
      it "should respond" do
        expect(subject).to respond_to(:is_enabled)
      end
      it "should not be valid if nil" do
        subject.is_enabled = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.is_enabled = ""
        expect(subject).to_not be_valid
      end
      it "should be valid if true" do
        subject.is_enabled = true
        expect(subject).to be_valid
      end
      it "should be valid if false" do
        subject.is_enabled = false
        expect(subject).to be_valid
      end
    end#is_enabled
    context "#ace_id" do
      it "should respond" do
        expect(subject).to respond_to(:ace_id)
      end
      it "should not be valid if nil" do
        subject.ace_id = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.ace_id = ""
        expect(subject).to_not be_valid
      end
      context "(when duplicate)" do
        before(:each) { FactoryGirl.create(:duplicate_editor_theme) }
        subject { FactoryGirl.build(:duplicate_editor_theme) }
        it "should not be valid" do
          expect(subject).to_not be_valid
        end
      end#(when duplicate)
    end#ace_id
    context "#users" do
      it "should respond" do
        expect(subject).to respond_to(:users)
      end
      it "should return ActiveRecord::Relation" do
        expect(subject.users).to be_a_kind_of(ActiveRecord::Relation)
      end
    end#users
    context "#to_option" do
      it "should respond" do
        expect(subject).to respond_to(:to_option)
      end
      it "should return an array" do
        expect(subject.to_option).to be_a_kind_of(Array)
      end
      it "should return expected" do
        output = [ subject.name, subject.ace_id ]
        expect(subject.to_option).to eq(output)
      end
    end#to_option
  end#(instance)
end#EditorTheme
