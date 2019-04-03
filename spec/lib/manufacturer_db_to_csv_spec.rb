require "rails_helper"

RSpec.describe ManufacturerDbToCsv do
  subject { described_class.new }
  let!(:manufacturer) {
    create(
      :manufacturer,
      id: "987d89e6-8d31-4b3a-b313-d56a22fb2f71",
      name: "Big Cheese",
      description: "Very cheesy",
      location: "Mount Cheese",
      verified: true,
      ul: "a",
      ul_c: "b",
    )
  }
  describe "#headers" do
    it "has the expected number of headers" do
      expect(subject.headers.count).to eql(7)
    end

    it "has the cd id is the first header" do
      expect(subject.headers.first).to eql(:id)
    end
  end

  describe "#body" do
    it "has the expected values in the body" do
      mat = subject.body.first.symbolize_keys
      expect(mat).to eql(
        id: "987d89e6-8d31-4b3a-b313-d56a22fb2f71",
        name: "Big Cheese",
        description: "Very cheesy",
        location: "Mount Cheese",
        verified: "true",
        ul: "a",
        ul_c: "b",
      )
    end
  end

  describe "#to_csv" do
    it "generates a csv from the data" do
      lines = subject.to_csv.split("\n")
      expect(lines.first).to start_with("id")
      expect(lines.second).to start_with(manufacturer.id)
    end
  end
end
