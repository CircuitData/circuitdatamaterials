require "rails_helper"

RSpec.describe ManufacturerCsvToDb do
  subject { described_class.new(csv) }

  let(:headers) {
    "id,name,description,location,verified,ul,ul_c"
  }
  let(:csv) {
    <<~CSV
      #{headers}
      987d89e6-8d31-4b3a-b313-d56a22fb2f71,Big Cheese,Very cheesy,Mount Cheese,true,a,b
    CSV
  }
  let(:manufacturer_data) {
    {
      id: "987d89e6-8d31-4b3a-b313-d56a22fb2f71",
      name: "Big Cheese",
      description: "Very cheesy",
      location: "Mount Cheese",
      verified: true,
      ul: "a",
      ul_c: "b",
    }
  }

  describe "#manufacturers" do
    it "has the expected number of manufacturers" do
      expect(subject.manufacturers.count).to eql(1)
    end

    it "converts the data into hashes" do
      row = subject.manufacturers.first.to_hash.symbolize_keys
      expect(row).to eql(manufacturer_data)
    end
  end

  describe "#load_into_db" do
    it "creates the manufacturer in the DB" do
      expect { subject.load_into_db }.to change { Manufacturer.count }.by(1)
    end

    it "populates the attributes correctly" do
      subject.load_into_db
      mat = Manufacturer.first

      attrs = mat.attributes.symbolize_keys.except(
        :created_at, :updated_at, :source, :source_id
      )
      expect(attrs).to include(manufacturer_data)
    end

    context "manufacturer already exists" do
      let!(:manufacturer) { Manufacturer.create!(manufacturer_data) }

      before do
        csv.sub!("Very cheesy", "not so cheesy")
      end

      it "updates the existing manufacturer" do
        expect { subject.load_into_db }.not_to change { Manufacturer.count }

        expect(manufacturer.reload.description).to eql("not so cheesy")
      end
    end
  end
end
