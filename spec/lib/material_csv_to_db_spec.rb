require "rails_helper"

RSpec.describe MaterialCsvToDb do
  subject { described_class.new(csv) }
  let(:headers) {
    "circuitdata_material_db_id,manufacturer,ul94,ipc_slash_sheet,cti,df,dielectric_breakdown,dk,electric_strength,finish,flexible,foil_roughness,function,group,ipc_sm_840_class,ipc_standard,link,mot,name,t260,t280,t300,td_min,tg_min,thermal_conductivity,water_absorption,z_cte,z_cte_after_tg,z_cte_before_tg"
  }
  let(:csv) {
    <<~CSV
      #{headers}
      987d89e6-8d31-4b3a-b313-d56a22fb2f71,Big Cheese,hb,1|2,12.0,14.0,16.0,18.0,20.0,glossy,true,V,final_finish,FR2,TF,12,http://example.com/cheesyLink,24.0,Cheese,28.0,30.0,32.0,34,36,38.0,44.0,46.0,48.0,50.0
    CSV
  }
  let!(:manufacturer) { create(:manufacturer, name: "Big Cheese") }
  let(:material_data) {
    {
      id: "987d89e6-8d31-4b3a-b313-d56a22fb2f71",
      cti: 12.0,
      df: 14.0,
      dielectric_breakdown: 16.0,
      dk: 18.0,
      electric_strength: 20.0,
      finish: "glossy",
      flexible: true,
      foil_roughness: "V",
      function: "final_finish",
      group: "FR2",
      ipc_slash_sheet: [1, 2],
      ipc_sm_840_class: "TF",
      ipc_standard: 12,
      link: "http://example.com/cheesyLink",
      mot: 24.0,
      name: "Cheese",
      t260: 28.0,
      t280: 30.0,
      t300: 32.0,
      td_min: 34,
      tg_min: 36,
      thermal_conductivity: 38.0,
      ul_94: "hb",
      water_absorption: 44.0,
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
        :manufacturer_id, :created_at, :updated_at, :source, :source_id, :version
      )
      expect(attrs).to include(material_data)
    end

    context "material already exists" do
      let!(:material) {
        Material.create!(material_data.merge(manufacturer: manufacturer))
      }

      before do
        csv.sub!("FR2", "FR4")
      end

      it "updates the existing material" do
        expect { subject.load_into_db }.not_to change { Material.count }

        expect(material.reload.group).to eql("FR4")
      end
    end

    context "the manufacturer does not exist" do
      before do
        csv.sub!("Big Cheese", "Little Cheese")
      end

      it "raises an error" do
        expect {
          subject.load_into_db
        }.to raise_error(MaterialCsvToDb::ManufacturerNotFound, /Little Cheese/)
      end
    end

    context "the manufacturer is blank" do
      let!(:material) {
        Material.create!(material_data.merge(manufacturer: manufacturer))
      }

      before do
        csv.sub!("Big Cheese", "")
      end

      it "updates the manufacturer to nil" do
        expect { subject.load_into_db }.to change { material.reload.manufacturer }.to(nil)
      end
    end

    context "the material is invalid" do
      before do
        csv.sub!("glossy", "matt")
      end

      it "raises and logs the error" do
        expected_message = "Material 987d89e6-8d31-4b3a-b313-d56a22fb2f71 is invalid: " \
        "Validation failed: Finish is not included in the list"
        expect {
          subject.load_into_db
        }.to raise_error(MaterialCsvToDb::InvalidRowError, expected_message)
      end
    end

    context "has minimal data" do
      let(:csv) {
        <<~CSV
          #{headers}
          1587901d-254c-47a1-9294-ea16c653b14d,"","",,"","","","","","","","",conductive,copper,"","","","",Copper,"","","","","","","","","",""
        CSV
      }
      it "imports the material" do
        expect { subject.load_into_db }.to change { Material.count }.by(1)
      end

      it "does not convert empty fields to zeros" do
        subject.load_into_db
        mat = Material.first
        expect(mat.cti).to be(nil)
        expect(mat.td_min).to be(nil)
      end
    end

    context "materials exist that are not in the CSV" do
      let!(:other_material) { create(:material) }

      it "removes the material not present" do
        expect(Material.count).to eql(1)

        subject.load_into_db
        expect(Material.count).to eql(1)
        expect(Material.first).not_to eql(other_material)
      end
    end
  end
end
