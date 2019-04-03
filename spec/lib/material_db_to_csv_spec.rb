require "rails_helper"

RSpec.describe MaterialDbToCsv do
  subject { described_class.new }
  let!(:manufacturer) { create(:manufacturer, name: "Big Cheese") }
  let!(:material) {
    create(
      :material,
      manufacturer: manufacturer,
      name: "Cheese",
      link: "cheezyLink",
      remark: "cheezyRemark",
      function: "final_finish",
      group: "FR2",
      flexible: true,
      additional: "adddedCheese",
      accept_equivalent: false,
      ul_94: "hb",
      verified: true,
      ipc_standard: 12,
      cti: 12,
      df: 14,
      dielectric_breakdown: 16,
      dk: 18,
      electric_strength: 20,
      filler: ["organic", "kaolin"],
      finish: "semi_glossy",
      flame_retardant: "red_phosphor",
      foil_roughness: "V",
      ipc_slash_sheet: ["1", "2"],
      frequency: "22",
      ipc_sm_840_class: "TF",
      mot: "24",
      reinforcement: "ne-glass",
      resin: "cyanate_ester",
      resin_content: "26",
      t260: "28",
      t280: "30",
      t300: "32",
      td_min: "34",
      tg_min: "36",
      thermal_conductivity: "38",
      thickness: "40",
      volume_resistivity: "42",
      water_absorption: "44",
      woven_reinforcement: true,
      z_cte: "46",
      z_cte_after_tg: "48",
      z_cte_before_tg: "50",
    )
  }
  describe "#headers" do
    it "has the expected number of headers" do
      expect(subject.headers.count).to eql(42)
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
        accept_equivalent: "false",
        additional: "adddedCheese",
        cti: "12.0",
        df: "14.0",
        dielectric_breakdown: "16.0",
        dk: "18.0",
        electric_strength: "20.0",
        filler: "organic|kaolin",
        finish: "semi_glossy",
        flame_retardant: "red_phosphor",
        flexible: "true",
        foil_roughness: "V",
        frequency: "22.0",
        function: "final_finish",
        group: "FR2",
        ipc_slash_sheet: "1|2",
        ipc_sm_840_class: "TF",
        ipc_standard: "12",
        link: "cheezyLink",
        manufacturer: "Big Cheese",
        mot: "24.0",
        name: "Cheese",
        reinforcement: "ne-glass",
        remark: "cheezyRemark",
        resin: "cyanate_ester",
        resin_content: "26.0",
        t260: "28.0",
        t280: "30.0",
        t300: "32.0",
        td_min: "34",
        tg_min: "36",
        thermal_conductivity: "38.0",
        thickness: "40.0",
        ul94: "hb",
        verified: "true",
        volume_resistivity: "42.0",
        water_absorption: "44.0",
        woven_reinforcement: "true",
        z_cte: "46.0",
        z_cte_after_tg: "48.0",
        z_cte_before_tg: "50.0",
      )
    end
  end

  describe "#to_csv" do
    it "generates a csv from the data" do
      lines = subject.to_csv.split("\n")
      expect(lines.first).to start_with("circuitdata_material_db_id")
      expect(lines.second).to start_with(material.id)
    end
  end
end
