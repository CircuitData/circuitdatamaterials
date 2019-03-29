require "rails_helper"

RSpec.describe DbToCsv do
  include FactoryBot::Syntax::Methods
  subject { described_class.new }
  let!(:manufacturer) { create(:manufacturer, name: "Big Cheese") }
  let!(:material) {
    create(
      :material,
      manufacturer: manufacturer,
      name: "Cheese",
      link: "cheezyLink",
      remark: "cheezyRemark",
      function: "cheezyFunk",
      group: "ABBA",
      flexible: true,
      additional: "adddedCheese",
      accept_equivalent: false,
      ul_94: "94Cheese",
      verified: true,
      ipc_standard: 12,
    )
  }
  let!(:cti) {
    create(
      :material_attribute,
      material: material,
      name: "cti",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "number", value: "12"),
      ],
    )
  }
  let!(:df) {
    create(
      :material_attribute,
      material: material,
      name: "df",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "number", value: "14"),
      ],
    )
  }
  let!(:dielectric_breakdown) {
    create(
      :material_attribute,
      material: material,
      name: "dielectric_breakdown",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "number", value: "16"),
      ],
    )
  }
  let!(:dk) {
    create(
      :material_attribute,
      material: material,
      name: "dk",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "number", value: "18"),
      ],
    )
  }
  let!(:electric_strength) {
    create(
      :material_attribute,
      material: material,
      name: "electric_strength",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "number", value: "20"),
      ],
    )
  }
  let!(:filler) {
    create(
      :material_attribute,
      material: material,
      name: "filler",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "1"),
        build(:material_attribute_value, value_type: "string", value: "2"),
      ],
    )
  }
  let!(:finish) {
    create(
      :material_attribute,
      material: material,
      name: "finish",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "a"),
      ],
    )
  }
  let!(:flame_retardant) {
    create(
      :material_attribute,
      material: material,
      name: "flame_retardant",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "chips"),
      ],
    )
  }
  let!(:foil_roughness) {
    create(
      :material_attribute,
      material: material,
      name: "foil_roughness",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "yes"),
      ],
    )
  }
  let!(:frequency) {
    create(
      :material_attribute,
      material: material,
      name: "frequency",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "22"),
      ],
    )
  }
  let!(:ipc_slash_sheet) {
    create(
      :material_attribute,
      material: material,
      name: "ipc_slash_sheet",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "1"),
        build(:material_attribute_value, value_type: "string", value: "2"),
      ],
    )
  }
  let!(:ipc_sm_840_class) {
    create(
      :material_attribute,
      material: material,
      name: "ipc_sm_840_class",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "high class"),
      ],
    )
  }
  let!(:mot) {
    create(
      :material_attribute,
      material: material,
      name: "mot",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "24"),
      ],
    )
  }
  let!(:reinforcement) {
    create(
      :material_attribute,
      material: material,
      name: "reinforcement",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "rebar"),
      ],
    )
  }
  let!(:resin) {
    create(
      :material_attribute,
      material: material,
      name: "resin",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "sticky"),
      ],
    )
  }
  let!(:resin_content) {
    create(
      :material_attribute,
      material: material,
      name: "resin_content",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "26"),
      ],
    )
  }
  let!(:t260) {
    create(
      :material_attribute,
      material: material,
      name: "t260",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "28"),
      ],
    )
  }
  let!(:t280) {
    create(
      :material_attribute,
      material: material,
      name: "t280",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "30"),
      ],
    )
  }
  let!(:t300) {
    create(
      :material_attribute,
      material: material,
      name: "t300",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "32"),
      ],
    )
  }
  let!(:td_min) {
    create(
      :material_attribute,
      material: material,
      name: "td_min",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "34"),
      ],
    )
  }
  let!(:tg_min) {
    create(
      :material_attribute,
      material: material,
      name: "tg_min",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "36"),
      ],
    )
  }

  let!(:thermal_conductivity) {
    create(
      :material_attribute,
      material: material,
      name: "thermal_conductivity",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "38"),
      ],
    )
  }
  let!(:thickness) {
    create(
      :material_attribute,
      material: material,
      name: "thickness",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "40"),
      ],
    )
  }
  let!(:volume_resistivity) {
    create(
      :material_attribute,
      material: material,
      name: "volume_resistivity",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "42"),
      ],
    )
  }
  let!(:water_absorption) {
    create(
      :material_attribute,
      material: material,
      name: "water_absorption",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "44"),
      ],
    )
  }
  let!(:woven_reinforcement) {
    create(
      :material_attribute,
      material: material,
      name: "woven_reinforcement",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: true),
      ],
    )
  }
  let!(:z_cte) {
    create(
      :material_attribute,
      material: material,
      name: "z_cte",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "46"),
      ],
    )
  }
  let!(:z_cte_after_tg) {
    create(
      :material_attribute,
      material: material,
      name: "z_cte_after_tg",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "48"),
      ],
    )
  }
  let!(:z_cte_before_tg) {
    create(
      :material_attribute,
      material: material,
      name: "z_cte_before_tg",
      material_attribute_values: [
        build(:material_attribute_value, value_type: "string", value: "50"),
      ],
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
      mat = subject.body.first
      expect(mat).to eql(
        circuitdata_material_db_id: material.id,
        accept_equivalent: false,
        additional: "adddedCheese",
        cti: 12,
        df: 14,
        dielectric_breakdown: 16,
        dk: 18,
        electric_strength: 20,
        filler: "1|2",
        finish: "a",
        flame_retardant: "chips",
        flexible: true,
        foil_roughness: "yes",
        frequency: 22,
        function: "cheezyFunk",
        group: "ABBA",
        ipc_slash_sheet: "1|2",
        ipc_sm_840_class: "high class",
        ipc_standard: 12,
        link: "cheezyLink",
        manufacturer: "Big Cheese",
        mot: 24,
        name: "Cheese",
        reinforcement: "rebar",
        remark: "cheezyRemark",
        resin: "sticky",
        resin_content: 26,
        t260: 28,
        t280: 30,
        t300: 32,
        td_min: 34,
        tg_min: 36,
        thermal_conductivity: 38,
        thickness: 40,
        ul94: "94Cheese",
        verified: true,
        volume_resistivity: 42,
        water_absorption: 44,
        woven_reinforcement: true,
        z_cte: 46,
        z_cte_after_tg: 48,
        z_cte_before_tg: 50,
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
