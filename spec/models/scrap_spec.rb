# == Schema Information
#
# Table name: scraps
#
#  id                 :integer          not null, primary key
#  http_method        :string(255)      default("GET"), not null
#  endpoint           :string(255)      not null
#  status_code        :integer          default(200), not null
#  content_type       :string(255)      default("application/json"), not null
#  body               :text             not null
#  private            :boolean          default(FALSE), not null
#  character_encoding :string(255)      default("UTF-8"), not null
#  pile_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#

require 'rails_helper'

describe Scrap do
  subject { Scrap }
  describe ".from_param" do
    before(:each) do
      allow(subject).to receive(:where).and_return(true)
    end
    it "should filter by proper values" do
      subject.from_param("foobar")
      expect(subject).to have_received(:where).with({ endpoint: "foobar" })
    end
  end

  context "(instance)" do
    subject { FactoryGirl.build(:scrap) }
    it { expect(subject).to be_valid }

    context "(validations)" do
      context "endpoint" do
        it "should not be valid if nil" do
          subject.endpoint = nil
          expect(subject).not_to be_valid
        end
        it "should not be valid if blank" do
          subject.endpoint = ""
          expect(subject).not_to be_valid
        end
        it "should be valid with unique string" do
          subject.endpoint = "very/unique/endpoint/right/here"
          expect(subject).to be_valid
        end
        context "if duplicate" do
          let(:dupe_scrap) { FactoryGirl.create(:scrap) }
          before(:each) { subject.endpoint = dupe_scrap.endpoint }
          context "for same pile" do
            before(:each) { subject.pile = dupe_scrap.pile }
            it "should not be valid" do
              expect(subject).not_to be_valid
            end
          end
          context "for different pile" do
            before(:each) { subject.pile = FactoryGirl.build(:pile) }
            it "should be valid" do
              expect(subject).to be_valid
            end
          end
        end
      end
      context "content_type" do
        it "should not be valid if nil" do
          subject.content_type = nil
          expect(subject).not_to be_valid
        end
        it "should not be valid if blank" do
          subject.content_type = ""
          expect(subject).not_to be_valid
        end
        it "should be valid with proper value" do
          subject.content_type = "text/plain"
          expect(subject).to be_valid
        end
      end
      context "content_type" do
        it "should not be valid if nil" do
          subject.body = nil
          expect(subject).not_to be_valid
        end
        it "should not be valid if blank" do
          subject.body = ""
          expect(subject).not_to be_valid
        end
        it "should be valid with proper value" do
          subject.body = "Hello World"
          expect(subject).to be_valid
        end
      end
      context "status_code" do
        it "should not be valid if nil" do
          subject.status_code = nil
          expect(subject).not_to be_valid
        end
        it "should be valid with proper value" do
          subject.status_code = 500
          expect(subject).to be_valid
        end
      end
      context "character_encoding" do
        it "should not be valid if nil" do
          subject.character_encoding = nil
          expect(subject).not_to be_valid
        end
        it "should not be valid if blank" do
          subject.character_encoding = ""
          expect(subject).not_to be_valid
        end
        it "should not be valid if not in list of valid values" do
          subject.character_encoding = "none"
          expect(subject).not_to be_valid
        end
        Scrap::ENCODINGS.each do |encoding|
          it "should be valid if '#{encoding}'" do
            subject.character_encoding = encoding
            expect(subject).to be_valid
          end
        end
      end
    end

    describe "#to_param" do
      it "should equal #endpoint" do
        expect(subject.to_param).to eq(subject.endpoint)
      end
    end
    describe "#pile" do
      it { expect(subject).to respond_to(:pile) }
    end
    describe "#user" do
      it { expect(subject).to respond_to(:user) }
      it "should be equal to pile.user" do
        expect(subject.user).to eq(subject.pile.user)
      end
    end

    describe "#render_options" do
      it "should be a hash" do
        expect(subject.render_options).to be_a_kind_of(Hash)
      end
      context "(return value)" do
        let(:opts) { subject.render_options }
        [:body, :content_type, :status].each do |key|
          it "should have key '#{key}'" do
            expect(opts).to have_key(key)
          end
        end
        it { expect(opts[:body]).to eq(subject.body) }
        it { expect(opts[:content_type]).to eq(subject.content_type) }
        it { expect(opts[:status]).to eq(subject.status_code) }
      end
    end#render_options

    describe "#http_headers" do
      it "should be a hash" do
        expect(subject.http_headers).to be_a_kind_of(Hash)
      end
      context "(return value)" do
        let(:headers) { subject.http_headers }
        it { expect(headers["Content-Type"]).to eq(subject.content_type) }
      end
    end
  end
end
