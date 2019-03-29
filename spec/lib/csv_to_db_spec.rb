require "rails_helper"

RSpec.describe CsvToDb do
  subject { described_class.new(csv) }
  let(:csv) {
    <<~CSV
      circuitdata_material_db_id,manufacturer,filler,ul94,ipc_slash_sheet,accept_equivalent,additional,cti,df,dielectric_breakdown,dk,electric_strength,finish,flame_retardant,flexible,foil_roughness,frequency,function,group,ipc_sm_840_class,ipc_standard,link,mot,name,reinforcement,remark,resin,resin_content,t260,t280,t300,td_min,tg_min,thermal_conductivity,thickness,verified,volume_resistivity,water_absorption,woven_reinforcement,z_cte,z_cte_after_tg,z_cte_before_tg
      987d89e6-8d31-4b3a-b313-d56a22fb2f71,Big Cheese,organic|kaolin,hb,1|2,false,adddedCheese,12.0,14.0,16.0,18.0,20.0,semi_glossy,red_phosphor,true,V,22.0,final_finish,FR2,TF,12,cheezyLink,24.0,Cheese,ne-glass,cheezyRemark,cyanate_ester,26.0,28.0,30.0,32.0,34,36,38.0,40.0,true,42.0,44.0,true,46.0,48.0,50.0
    CSV
  }
  let!(:manufacturer) { create(:manufacturer, name: "Big Cheese") }
  let(:material_data) {
    {
      id: "987d89e6-8d31-4b3a-b313-d56a22fb2f71",
      accept_equivalent: false,
      additional: "adddedCheese",
      cti: 12.0,
      df: 14.0,
      dielectric_breakdown: 16.0,
      dk: 18.0,
      electric_strength: 20.0,
      filler: ["organic", "kaolin"],
      finish: "semi_glossy",
      flame_retardant: "red_phosphor",
      flexible: true,
      foil_roughness: "V",
      frequency: 22.0,
      function: "final_finish",
      group: "FR2",
      ipc_slash_sheet: [1, 2],
      ipc_sm_840_class: "TF",
      ipc_standard: 12,
      link: "cheezyLink",
      mot: 24.0,
      name: "Cheese",
      reinforcement: "ne-glass",
      remark: "cheezyRemark",
      resin: "cyanate_ester",
      resin_content: 26.0,
      t260: 28.0,
      t280: 30.0,
      t300: 32.0,
      td_min: 34,
      tg_min: 36,
      thermal_conductivity: 38.0,
      thickness: 40.0,
      ul_94: "hb",
      verified: true,
      volume_resistivity: 42.0,
      water_absorption: 44.0,
      woven_reinforcement: true,
      z_cte: 46.0,
      z_cte_after_tg: 48.0,
      z_cte_before_tg: 50.0,
    }
  }
  describe "#materials" do
    it "has the expected number of materials" do
      expect(subject.materials.count).to eql(1)
    end

    it "converts the data into hashes" do
      row = subject.materials.map(&:to_hash).first.symbolize_keys
      expect(row).to eql(material_data.merge(manufacturer: manufacturer))
    end
  end

  describe "#load_into_db" do
    it "creates the material in the DB" do
      expect { subject.load_into_db }.to change { Material.count }.by(1)
    end

    it "populates the attributes correctly" do
      subject.load_into_db
      mat = Material.first

      expect(mat.manufacturer).to eql(manufacturer)
      attrs = mat.attributes.symbolize_keys.except(
        :manufacturer_id, :created_at, :updated_at, :source, :source_id
      )
      expect(attrs).to include(material_data)
    end
  end
end
