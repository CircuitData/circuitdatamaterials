require "rails_helper"

RSpec.describe "Importing csv into db" do
  subject { described_class.new }
  let(:path) { Rails.root.join("lib", "data", "materials.csv") }
  let(:data) { File.open(path).read }
  let(:manufacturer_names) {
    [
      "AISMALIBAR",
      "Allstar Zs",
      "Isola",
      "Arlon",
      "Cambridge Nanotherm",
      "CeramTec",
      "CHAOSHUN",
      "Chin-Shi Electronic Materials TW",
      "Dongli (HeShan DongLi Electronic)",
      "Doosan",
      "Dupont",
      "Elektro Isola",
      "EMC",
      "GORE",
      "Grace",
      "Grand-Tag",
      "Greenmark",
      "HANWHA",
      "Hitachi",
      "Innox",
      "ITEQ",
      "Jiangsu Lianxin",
      "Jumbo",
      "Kinwong",
      "Mitsubishi",
      "Nam Hing",
      "Nanya",
      "PIC",
      "PTTC",
      "Rogers",
      "Shinemore",
      "Taconic",
      "Thinflex",
      "Zhejiang Huazheng",
      "Ventec",
      "KREMPEL GmbH",
      "Kingboard",
      "Bergquist",
      "TUC",
      "Laird",
      "Lamitec-Dielektra GmbH",
      "MSC Polymer",
      "Nanmei",
      "Nelco",
      "Nippon Steel/Espanex",
      "Panasonic",
      "Polytronics",
      "Shanghai global (Goldenmax International)",
      "Shengyi",
      "Sumitomo",
      "TaiFlex",
      "Totking",
      "Uniplus",
      "WL (China)",
    ]
  }

  before do
    manufacturer_names.each do |name|
      create(:manufacturer, name: name)
    end
  end

  it "imports successfully" do
    CsvToDb.new(data).load_into_db
  end

  it "dumps into the same content" do
    CsvToDb.new(data).load_into_db
    expect(DbToCsv.new.to_csv)
  end
end
