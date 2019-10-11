require "rails_helper"

RSpec.describe MaterialDbToCsv do
  subject { described_class.new }
  let!(:manufacturer) { create(:manufacturer, name: "Big Cheese") }
  let!(:material) {
    create(
      :material,
      manufacturer: manufacturer,
      name: "Cheese",
      link: "http://example.com/cheezyLink",
      function: "final_finish",
      group: "FR2",
      flexible: true,
      ul_94: "hb",
      ipc_standard: 12,
      cti: 12,
      df: 14,
      dielectric_breakdown: 16,
      dk: 18,
      electric_strength: 20,
      finish: "glossy",
      foil_roughness: "V",
      ipc_slash_sheet: ["1", "2"],
      ipc_sm_840_class: "TF",
      mot: "24",
      t260: "28",
      t280: "30",
      t300: "32",
      td_min: "34",
      tg_min: "36",
      thermal_conductivity: "38",
      water_absorption: "44",
      z_cte: "46",
      z_cte_after_tg: "48",
      z_cte_before_tg: "50",
    )
  }
  describe "#headers" do
    it "has the expected number of headers" do
      expect(subject.headers.count).to eql(30)
    end

    it "has the cd id is the first header" do
      expect(subject.headers.first).to eql(:circuitdata_material_db_id)
    end
  end

  describe "#body" do
    it "has the expected values in the body" do
      mat = subject.body.first.symbolize_keys
      expect(mat).to eql(
        circuitdata_material_db_id: material.id,
        cti: "12",
        df: "14.0",
        dielectric_breakdown: "16.0",
        dk: "18.0",
        electric_strength: "20.0",
        finish: "glossy",
        flexible: "true",
        foil_roughness: "V",
        function: "final_finish",
        group: "FR2",
        ipc_slash_sheet: "1|2",
        ipc_sm_840_class: "TF",
        ipc_standard: "12",
        link: "http://example.com/cheezyLink",
        manufacturer: "Big Cheese",
        mot: "24.0",
        name: "Cheese",
        t260: "28.0",
        t280: "30.0",
        t300: "32.0",
        td_min: "34",
        tg_min: "36",
        thermal_conductivity: "38.0",
        ul94: "hb",
        water_absorption: "44.0",
        z_cte: "46.0",
        z_cte_after_tg: "48.0",
        z_cte_before_tg: "50.0",
        verified: "false",
      )
    end
  end

  describe "#to_csv" do
    it "generates a csv from the data" do
      lines = subject.to_csv.split("\n")
      expect(lines.first).to start_with("circuitdata_material_db_id")
      expect(lines.second).to start_with(",,,,,°C")
      expect(lines.third).to start_with(material.id)
    end
  end
end
