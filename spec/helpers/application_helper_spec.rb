require 'rails_helper'

describe ApplicationHelper do
  context "#method_label" do
    it "should respond" do
      expect(helper).to respond_to(:method_label)
    end
    {
      "get" => "label-success",
      "post" => "label-primary",
      "put" => "label-warning",
      "patch" => "label-warning",
      "delete" => "label-danger",
      "head" => "label-info",
      "options" => "label-info",
      "copy" => "label-default",
      "link" => "label-default",
      "unlink" => "label-default",
      "purge" => "label-default"
    }.each do |m,lbl|
      output = %Q{<strong class="label #{lbl}">#{m.upcase}</strong>}
      context "when given '#{m}'" do
        it "should return expected" do
          expect(helper.method_label(m)).to eq(output)
        end
      end
      context "when given '#{m.upcase}'" do
        it "should return expected" do
          expect(helper.method_label(m.upcase)).to eq(output)
        end
      end
    end
  end#method_label
  context "#status_label" do
    it "should respond" do
      expect(helper).to respond_to(:status_label)
    end
    [
      [99, "label-dark"], # unlikely but possible
      [100, "label-info"], [199, "label-info"],
      [200, "label-success"], [299, "label-success"],
      [300, "label-warning"], [399, "label-warning"],
      [400, "label-danger"], [499, "label-danger"],
      [500, "label-dark"], [599, "label-dark"],
      [600, "label-dark"] # unlikely but possible
    ].each do |pair|
      output = %Q{<strong class="label #{pair.last}">#{pair.first}</strong>}
      it "should return '#{output}' when given #{pair.first}" do
        expect(helper.status_label(pair.first)).to eq(output)
      end
    end
  end#status_label
  context "#user_api_scrap_path" do
    it "should respond" do
      expect(helper).to respond_to(:user_api_scrap_path)
    end
    it "should respond appropriately" do
      scrap = FactoryGirl.create(:scrap)
      user = scrap.user
      output = helper.user_api_endpoint_path(user, scrap.endpoint)
      expect(helper.user_api_scrap_path(user, scrap)).to eq(output)
    end
  end#user_api_scrap_path
  context "#user_api_scrap_url" do
    it "should respond" do
      expect(helper).to respond_to(:user_api_scrap_url)
    end
    it "should respond appropriately" do
      scrap = FactoryGirl.create(:scrap)
      user = scrap.user
      output = helper.user_api_endpoint_url(user, scrap.endpoint)
      expect(helper.user_api_scrap_url(user, scrap)).to eq(output)
    end
  end#user_api_scrap_url
end
