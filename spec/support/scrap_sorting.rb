shared_context "sorting scraps" do
  let(:arel) { double(ActiveRecord::Relation) }
  before(:each) do
    allow(arel).to receive(:oldest).and_return(arel)
    allow(arel).to receive(:newest).and_return(arel)
    allow(arel).to receive(:lively).and_return(arel)
    allow(arel).to receive(:stagnant).and_return(arel)
  end

  describe "#apply_sorting" do
    it "responds" do
      expect(controller).to respond_to(:apply_sorting)
    end
    it "returns ARel object" do
      expect(controller.apply_sorting(Scrap, "foobar")).to be_a_kind_of(ActiveRecord::Relation)
    end
    it "expects two arguments (ARel, String)" do
      expect(controller.method(:apply_sorting).arity).to eq(2)
    end
    it "doesn't error" do
      expect{
        controller.apply_sorting(Scrap, "foobar")
      }.to_not raise_error
    end
    context "when 'created_asc' sort" do
      let(:sort) { "created_asc" }
      before(:each) { controller.apply_sorting(arel, sort) }
      it "calls arel.oldest" do
        expect(arel).to have_received(:oldest)
      end
    end
    context "when 'created_desc' sort" do
      let(:sort) { "created_desc" }
      before(:each) { controller.apply_sorting(arel, sort) }
      it "calls arel.newest" do
        expect(arel).to have_received(:newest)
      end
    end
    context "when 'updated_asc' sort" do
      let(:sort) { "updated_asc" }
      before(:each) { controller.apply_sorting(arel, sort) }
      it "calls arel.stagnant" do
        expect(arel).to have_received(:stagnant)
      end
    end
    context "when 'updated_desc' sort" do
      let(:sort) { "updated_desc" }
      before(:each) { controller.apply_sorting(arel, sort) }
      it "calls arel.lively" do
        expect(arel).to have_received(:lively)
      end
    end
    context "when 'foobar' sort" do
      let(:sort) { "foobar" }
      before(:each) { controller.apply_sorting(arel, sort) }
      it "calls arel.lively" do
        expect(arel).to have_received(:lively)
      end
    end
  end#apply_sorting
end#sorting scraps
