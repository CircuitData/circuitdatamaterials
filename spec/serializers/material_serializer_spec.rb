require "rails_helper"

RSpec.describe MaterialSerializer do
  subject { described_class.new(material) }
  let(:material) { create(:material) }

  it "serializes valid materials" do
    parsed_data = JSON.parse(subject.to_json, symbolize_names: true)
    validator = Circuitdata::MaterialValidator.new(parsed_data)
    validator.valid?
    expect(validator.errors).to eql([])
  end
end
