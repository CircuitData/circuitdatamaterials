require "rails_helper"

RSpec.describe "/api/v1/materials" do
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

  it "returns the materials in the DB" do
    get "/api/v1/materials"
    expect(response).to have_http_status(200)

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_data.length).to eql(1)
    mat = parsed_data.first
    expect(mat.except(:attributes)).to eql({
      circuitdata_material_db_id: material.id,
      manufacturer: "Big Cheese",
      name: "Cheese",
      ul94: "hb",
      link: "http://example.com/cheezyLink",
      flexible: true,
      function: "final_finish",
      group: "FR2",
      version: 2.0,
    })
    expect(mat[:attributes]).to eql(
      ipc_standard: 12,
      cti: 12,
      df: 14.0,
      dielectric_breakdown: 16.0,
      dk: 18.0,
      electric_strength: 20.0,
      finish: "glossy",
      foil_roughness: "V",
      ipc_slash_sheet: [1, 2],
      ipc_sm_840_class: "TF",
      mot: 24.0,
      t260: 28.0,
      t280: 30.0,
      t300: 32.0,
      td_min: 34,
      tg_min: 36,
      thermal_conductivity: 38.0,
      water_absorption: 44.0,
      z_cte: 46.0,
      z_cte_after_tg: 48.0,
      z_cte_before_tg: 50.0,
    )
  end

  it "returns valid circuitdata materials" do
    get "/api/v1/materials"

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    validator = Circuitdata::MaterialValidator.new(parsed_data.first)
    validator.valid?
    expect(validator.errors).to eql([])
  end

  context "material has minimal attributes" do
    let!(:material) { create(:material) }
    it "returns valid circuitdata materials" do
      get "/api/v1/materials"

      parsed_data = JSON.parse(response.body, symbolize_names: true)
      validator = Circuitdata::MaterialValidator.new(parsed_data.first)
      validator.valid?
      expect(validator.errors).to eql([])
    end
  end
end
