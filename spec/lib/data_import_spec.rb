require "rails_helper"

RSpec.describe "Importing csv into db" do
  let(:manufacturer_path) { Rails.root.join("lib", "data", "manufacturers.csv") }
  let(:manufacturer_data) { File.open(manufacturer_path).read }
  let(:material_path) { Rails.root.join("lib", "data", "materials.csv") }
  let(:material_data) { File.open(material_path).read }

  it "imports successfully" do
    ManufacturerCsvToDb.new(manufacturer_data).load_into_db
    MaterialCsvToDb.new(material_data).load_into_db
  end

  context "data is loaded into DB" do
    before do
      ManufacturerCsvToDb.new(manufacturer_data).load_into_db
      MaterialCsvToDb.new(material_data).load_into_db
    end

    it "dumps into the same content" do
      expect(ManufacturerDbToCsv.new.to_csv).to eql(manufacturer_data)
      expect(MaterialDbToCsv.new.to_csv).to eql(material_data)
    end

    it "has no extraneous materials present" do
      material_paths = Material.includes(:manufacturer).with_manufacturer
        .map(&:datasheet)
        .select(&:exist?)
        .map(&:file_path)
        .map(&:to_s)
      path = Rails.root.join("lib", "datasheets", "**", "*.pdf")
      existing_paths = Dir[path].map(&:to_s)
      extra_files = existing_paths - material_paths

      expect(extra_files).to eql([])
    end
  end
end
