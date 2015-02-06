# == Schema Information
#
# Table name: scraps
#
#  http_method        :string(255)      default("GET"), not null
#  endpoint           :string(255)      not null
#  status_code        :integer          default(200), not null
#  content_type       :string(255)      default("application/json"), not null
#  body               :text             not null
#  is_public          :boolean          default(TRUE), not null
#  description        :text
#  language           :string(255)      default("json"), not null
#  character_encoding :string(255)      default("UTF-8"), not null
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  uid                :string(255)      not null, primary key
#

require 'rails_helper'

describe Scrap do
  subject { Scrap }

  describe "(class)" do
    context ".primary_key" do
      it "should respond" do
        expect(subject).to respond_to(:primary_key)
      end
      it "should be 'uid'" do
        expect(subject.primary_key).to eq("uid")
      end
    end#.primary_key
    context "HTTP_METHODS" do
      it "should respond" do
        expect(subject.constants).to include(:HTTP_METHODS)
      end
      it "should be an array" do
        expect(subject::HTTP_METHODS).to be_a_kind_of(Array)
      end
      it "should not be empty" do
        expect(subject::HTTP_METHODS).to_not be_empty
      end
      it "should be frozen" do
        expect(subject::HTTP_METHODS).to be_frozen
      end
    end#HTTP_METHODS
    context "ENCODINGS" do
      it "should respond" do
        expect(subject.constants).to include(:ENCODINGS)
      end
      it "should be an array" do
        expect(subject::ENCODINGS).to be_a_kind_of(Array)
      end
      it "should not be empty" do
        expect(subject::ENCODINGS).to_not be_empty
      end
      it "should be frozen" do
        expect(subject::ENCODINGS).to be_frozen
      end
    end#ENCODINGS
    context "LANGUAGES" do
      it "should respond" do
        expect(subject.constants).to include(:LANGUAGES)
      end
      it "should be a hash" do
        expect(subject::LANGUAGES).to be_a_kind_of(Hash)
      end
      it "should not be empty" do
        expect(subject::LANGUAGES).to_not be_empty
      end
      it "should be frozen" do
        expect(subject::LANGUAGES).to be_frozen
      end
    end#LANGUAGES
    context "(scopes)" do
      before(:each) do
        Scrap.destroy_all
        @scrap1 = FactoryGirl.create(:visible_scrap, created_at: 30.minutes.ago, updated_at: 10.minutes.ago)
        @scrap2 = FactoryGirl.create(:visible_scrap, created_at: 20.minutes.ago, updated_at: 1.minute.ago)
        @scrap3 = FactoryGirl.create(:invisible_scrap, created_at: 10.minutes.ago, updated_at: 5.minutes.ago)
      end
      context "(ordering scopes)" do
        describe ".newest" do
          it "should respond" do
            expect(subject).to respond_to(:newest)
          end
          it "should return in correct order" do
            expect(subject.newest.to_a).to eq([@scrap3, @scrap2, @scrap1])
          end
        end#.newest
        describe ".oldest" do
          it "should respond" do
            expect(subject).to respond_to(:oldest)
          end
          it "should return in correct order" do
            expect(subject.oldest.to_a).to eq([@scrap1, @scrap2, @scrap3])
          end
        end#.oldest
        describe ".lively" do
          it "should respond" do
            expect(subject).to respond_to(:lively)
          end
          it "should return in correct order" do
            expect(subject.lively.to_a).to eq([@scrap2, @scrap3, @scrap1])
          end
        end#.lively
        describe ".stagnant" do
          it "should respond" do
            expect(subject).to respond_to(:stagnant)
          end
          it "should return in correct order" do
            expect(subject.stagnant.to_a).to eq([@scrap1, @scrap3, @scrap2])
          end
        end#.stagnant
      end#ordering scopes
      context "(filtering scopes)" do
        describe ".visible" do
          it "should respond" do
            expect(subject).to respond_to(:visible)
          end
          it "should count two results" do
            expect(subject.visible.count).to be(2)
          end
        end#.visible
        describe ".invisible" do
          it "should respond" do
            expect(subject).to respond_to(:invisible)
          end
          it "should count one result" do
            expect(subject.invisible.count).to be(1)
          end
        end#.invisible
      end#filtering scopes
    end#(scopes)
  end#(class)


  describe "(instance)" do
    subject { FactoryGirl.build(:scrap) }
    it "should be valid from FactoryGirl" do
      expect(subject).to be_valid
    end
    context "#user" do
      it "should respond" do
        expect(subject).to respond_to(:user)
      end
      it "should return a User" do
        expect(subject.user).to be_a_kind_of(User)
      end
      it "should not be valid if nil" do
        subject.user = nil
        expect(subject).to_not be_valid
      end
    end#user
    context "#http_method" do
      it "should respond" do
        expect(subject).to respond_to(:http_method)
      end
      it "should not be valid if nil" do
        subject.http_method = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.http_method = ""
        expect(subject).to_not be_valid
      end
      context "(within known values)" do
        Scrap::HTTP_METHODS.each do |m|
          it "should be valid as '#{m}'" do
            subject.http_method = m
            expect(subject).to be_valid
          end
          it "should not be valid as '#{m.downcase}'" do
            subject.http_method = m.downcase
            expect(subject).to_not be_valid
          end
        end
      end#(within known values)
      context "(outside known values)" do
        ["GODZILLA","ALIENS","ZEUS"].each do |m|
          it "should not be valid as '#{m}'" do
            subject.http_method = m
            expect(subject).to_not be_valid
          end
        end
      end#(outside known values)
    end#http_method
    context "#endpoint" do
      it "should respond" do
        expect(subject).to respond_to(:endpoint)
      end
      it "should not be valid if nil" do
        subject.endpoint = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.endpoint = ""
        expect(subject).to_not be_valid
      end
      context "(duplicate scrap)" do
        before(:each) do
          @existing_scrap = FactoryGirl.create(:duplicate_scrap)
        end
        subject { FactoryGirl.build(:duplicate_scrap, user: @existing_scrap.user) }
        it "should not be valid" do
          expect(subject).to_not be_valid
        end
        context "with unique http method" do
          it "should be valid" do
            subject.http_method = "POST"
            expect(subject).to be_valid
          end
        end
        context "with unique user" do
          it "should be valid" do
            subject.user = FactoryGirl.create(:user)
            expect(subject).to be_valid
          end
        end
        context "with unique endpoint value" do
          it "should be valid" do
            subject.endpoint += "unique"
            expect(subject).to be_valid
          end
        end
      end#(duplicate scrap)
    end#endpoint
    context "#status_code" do
      it "should respond" do
        expect(subject).to respond_to(:status_code)
      end
      it "should not be valid if nil" do
        subject.status_code = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.status_code = ""
        expect(subject).to_not be_valid
      end
      it "should not be valid if string" do
        subject.status_code = "n/a"
        expect(subject).to_not be_valid
      end
      it "should not be valid if float" do
        subject.status_code = 12.34
        expect(subject).to_not be_valid
      end
      it "should be valid if integer" do
        subject.status_code = 200
        expect(subject).to be_valid
      end
      it "should not be valid if less than 100" do
        subject.status_code = 99
        expect(subject).to_not be_valid
      end
      it "should not be valid if over 599" do
        subject.status_code = 600
        expect(subject).to_not be_valid
      end
    end#status_code
    context "#content_type" do
      it "should respond" do
        expect(subject).to respond_to(:content_type)
      end
      it "should not be valid if nil" do
        subject.content_type = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.content_type = ""
        expect(subject).to_not be_valid
      end
    end#status_code
    context "#body" do
      it "should respond" do
        expect(subject).to respond_to(:body)
      end
      it "should not be valid if nil" do
        subject.body = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.body = ""
        expect(subject).to_not be_valid
      end
    end#body
    context "#is_public" do
      it "should respond" do
        expect(subject).to respond_to(:is_public)
      end
      it "should not be valid if nil" do
        subject.is_public = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.is_public = ""
        expect(subject).to_not be_valid
      end
    end#is_public
    context "#description" do
      it "should respond" do
        expect(subject).to respond_to(:description)
      end
    end#description
    context "#language" do
      it "should respond" do
        expect(subject).to respond_to(:language)
      end
      it "should not be valid if nil" do
        subject.language = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.language = ""
        expect(subject).to_not be_valid
      end
      context "(within known values)" do
        Scrap::LANGUAGES.values.each do |lang|
          it "should be valid as '#{lang}'" do
            subject.language = lang
            expect(subject).to be_valid
          end
        end
      end#(within known values)
      context "(outside known values)" do
        [ "brainfuck", "gojirra", "lolcat" ].each do |lang|
          it "should not be valid as '#{lang}'" do
            subject.language = lang
            expect(subject).to_not be_valid
          end
        end
      end#(outside known values)
    end#language
    context "#character_encoding" do
      it "should respond" do
        expect(subject).to respond_to(:character_encoding)
      end
      it "should not be valid if nil" do
        subject.character_encoding = nil
        expect(subject).to_not be_valid
      end
      it "should not be valid if blank" do
        subject.character_encoding = ""
        expect(subject).to_not be_valid
      end
      context "(within known values)" do
        Scrap::ENCODINGS.each do |enc|
          it "should be valid as '#{enc}'" do
            subject.character_encoding = enc
            expect(subject).to be_valid
          end
        end
      end#(within known values)
      context "(outside known values)" do
        [ "UTF-7", "UTF-15", "ISO-8859-0" ].each do |enc|
          it "should not be valid as '#{enc}'" do
            subject.character_encoding = enc
            expect(subject).to_not be_valid
          end
        end
      end#(outside known values)
    end#character_encoding
    context "#uid" do
      it "should respond" do
        expect(subject).to respond_to(:uid)
      end
    end#uid
    describe "#generate_uid!" do
      it "should respond" do
        expect(subject).to respond_to(:generate_uid!)
      end
      it "should change the value of uid" do
        old_uid = subject.uid
        subject.generate_uid!
        expect(subject.uid).to_not eq(old_uid)
      end
    end#generate_uid!
    describe "#ensure_uid!" do
      it "should respond" do
        expect(subject).to respond_to(:ensure_uid!)
      end
      it "should set uid when blank" do
        subject.uid = nil
        subject.ensure_uid!
        expect(subject.uid).to_not be_blank
      end
      it "should not set uid when not blank" do
        subject.uid = "foobar"
        subject.ensure_uid!
        expect(subject.uid).to eq("foobar")
      end
      context "when validating" do
        it "should be called" do
          allow(subject).to receive(:ensure_uid!)
          subject.valid?
          expect(subject).to have_received(:ensure_uid!)
        end
        it "should set uid" do
          expect(subject.uid).to be_blank
          subject.valid?
          expect(subject.uid).not_to be_blank
        end
      end
    end#ensure_uid!
    describe "#http_headers" do
      it "should be a hash" do
        expect(subject.http_headers).to be_a_kind_of(Hash)
      end
      context "(return value)" do
        let(:headers) { subject.http_headers }
        it { expect(headers["Content-Type"]).to eq(subject.content_type) }
        it { expect(headers["Access-Control-Allow-Origin"]).to be_present }
        it { expect(headers["Access-Control-Allow-Origin"]).to eq('*') }
      end
    end#http_headers
    describe "#to_param" do
      it "should equal #uid" do
        expect(subject.to_param).to eq(subject.uid)
      end
    end#to_param
    describe "#render_options" do
      it "should respond" do
        expect(subject).to respond_to(:render_options)
      end
      it "should be a hash" do
        expect(subject.render_options).to be_a_kind_of(Hash)
      end
      it "should not be empty" do
        expect(subject.render_options).to_not be_empty
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
      it 'should pass :liquid value to #liquid_body' do
        liquid_opts = { 'foo' => 'bar' }
        allow(subject).to receive(:liquid_body)
        subject.render_options({:liquid => liquid_opts})
        expect(subject).to have_received(:liquid_body).with(liquid_opts)
      end
    end#render_options
    describe "#body_lines" do
      it "should respond" do
        expect(subject).to respond_to(:body_lines)
      end
      it "should return an array" do
        expect(subject.body_lines).to be_a_kind_of(Array)
      end
      context 'given (\r\n) in body' do
        before(:each) { subject.body = "foo\r\nbar" }
        it "should return expected results" do
          expect(subject.body_lines).to eq(["foo", "bar"])
        end
      end
      context 'given (\r) in body' do
        before(:each) { subject.body = "foo\rbar" }
        it "should return expected results" do
          expect(subject.body_lines).to eq(["foo", "bar"])
        end
      end
      context 'given (\n) in body' do
        before(:each) { subject.body = "foo\nbar" }
        it "should return expected results" do
          expect(subject.body_lines).to eq(["foo", "bar"])
        end
      end
    end#body_lines
    describe "#truncate_body" do
      before(:each) do
        fake_lines = ["1", "2", "3", "4", "5"]
        allow(subject).to receive(:body_lines).and_return(fake_lines)
      end
      it "should respond" do
        expect(subject).to respond_to(:truncate_body)
      end
      context "given 3 lines" do
        it "should return expected" do
          expect(subject.truncate_body(3)).to eq("1\n2\n3\n...")
        end
      end
      context "given 10 lines" do
        it "should return expected" do
          expect(subject.truncate_body(10)).to eq("1\n2\n3\n4\n5")
        end
      end
    end#truncate_body
    describe "#liquid_body" do
      before(:each) do
        subject.body = "{{ foo }}"
      end
      it "should respond" do
        expect(subject).to respond_to(:liquid_body)
      end
      it "should always return a string" do
        expect(subject.liquid_body).to be_a_kind_of(String)
      end
      context "(empty hash of values given)" do
        it "should return empty string" do
          expect(subject.liquid_body({})).to eq("")
        end
      end
      context "(values given for keys used)" do
        it "should return expected value" do
          values = {
            'foo' => 'bar'
          }
          expect(subject.liquid_body(values)).to eq("bar")
        end
      end
    end
  end#(instance)
end
