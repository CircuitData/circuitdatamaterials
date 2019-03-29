require "rails_helper"

RSpec.describe "/materials" do
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
      cti: 12,
      df: 14,
      dielectric_breakdown: 16,
      dk: 18,
      electric_strength: 20,
      filler: [1, 2],
      finish: "a",
      flame_retardant: "chips",
      foil_roughness: "yes",
      ipc_slash_sheet: ["1", "2"],
      frequency: "22",
      ipc_sm_840_class: "high class",
      mot: "24",
      reinforcement: "rebar",
      resin: "sticky",
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

  it "returns the materials in the DB" do
    get "/materials"
    expect(response).to have_http_status(200)

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_data.length).to eql(1)
    mat = parsed_data.first
    expect(mat.except(:attributes)).to eql({
      circuitdata_material_db_id: material.id,
      manufacturer: "Big Cheese",
      name: "Cheese",
      remark: "cheezyRemark",
      ul94: "94Cheese",
      link: "cheezyLink",
      flexible: true,
      accept_equivalent: false,
    })
    expect(mat[:attributes]).to eql(
      function: "cheezyFunk",
      group: "ABBA",
      flexible: true,
      additional: "adddedCheese",
      ul_94: "94Cheese",
      verified: true,
      ipc_standard: 12,
      cti: 12.0,
      df: 14.0,
      dielectric_breakdown: 16.0,
      dk: 18.0,
      electric_strength: 20.0,
      filler: ["1", "2"],
      finish: "a",
      flame_retardant: "chips",
      foil_roughness: "yes",
      ipc_slash_sheet: [1, 2],
      frequency: 22.0,
      ipc_sm_840_class: "high class",
      mot: 24.0,
      reinforcement: "rebar",
      resin: "sticky",
      resin_content: 26.0,
      t260: 28.0,
      t280: 30.0,
      t300: 32.0,
      td_min: 34.0,
      tg_min: 36.0,
      thermal_conductivity: 38.0,
      thickness: 40.0,
      volume_resistivity: 42.0,
      water_absorption: 44.0,
      woven_reinforcement: true,
      z_cte: 46.0,
      z_cte_after_tg: 48.0,
      z_cte_before_tg: 50.0,
    )
  end
end
