require "rails_helper"

RSpec.describe Datasheet do
  let(:material) { double(:material, manufacturer_name: manufacturer, name: name) }
  let(:manufacturer) { "Kingboard" }
  let(:name) { "HF-140" }

  subject { described_class.new(material) }

  describe "#exist?" do
    it { is_expected.to exist }

    context "when material does not exist" do
      let(:name) { "pizza" }
      it { is_expected.not_to exist }
    end
  end

  describe "#file_path" do
    let(:expected_path) { Rails.root.join("lib", "datasheets", "kingboard", "hf_140.pdf") }
    it "is the correct file path" do
      expect(subject.file_path).to eql(expected_path)
    end

    context "when name has spaces" do
      let(:name) { "piz za" }
      let(:expected_path) { Rails.root.join("lib", "datasheets", "kingboard", "piz_za.pdf") }

      it "replaces spaces with underscores" do
        expect(subject.file_path).to eql(expected_path)
      end
    end

    context "when manufacturer has spaces" do
      let(:manufacturer) { "Bar ry" }
      let(:expected_path) { Rails.root.join("lib", "datasheets", "bar_ry", "hf_140.pdf") }

      it "replaces spaces with underscores" do
        expect(subject.file_path).to eql(expected_path)
      end
    end

    context "when manufacturer has non alpha numeric characters" do
      let(:manufacturer) { "Bar&-ry" }
      let(:expected_path) { Rails.root.join("lib", "datasheets", "bar_ry", "hf_140.pdf") }

      it "replaces characters with a single underscore" do
        expect(subject.file_path).to eql(expected_path)
      end
    end
  end
end
