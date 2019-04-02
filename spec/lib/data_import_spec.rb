require "rails_helper"

RSpec.describe "Importing csv into db" do
  subject { described_class.new }
  let(:path) { Rails.root.join("lib", "data", "materials.csv") }
  let(:data) { File.open(path).read }
  let(:manufacturer_names) {
    [
      "AISMALIBAR",
      "Allstar Zs",
      "AMC (TW)",
      "Isola",
      "Arlon",
      "Cambridge Nanotherm",
      "CeramTec",
      "CHAOSHUN",
      "Chin-Shi Electronic Materials TW",
      "Dongli (HeShan DongLi Electronic)",
      "Doosan",
      "Dongguan Langban",
      "Dupont",
      "Electra",
      "Elektro Isola",
      "EMC",
      "Eternal",
      "Fotochem",
      "Gin Hwa",
      "Goo Chemicals",
      "GORE",
      "Grace",
      "Grand-Tag",
      "Greencure",
      "Greenmark",
      "HANWHA",
      "HongDa",
      "Hitachi",
      "Huntsman",
      "Innox",
      "ITEQ",
      "Jiangsu Lianxin",
      "Jumbo",
      "Kuangshun",
      "Kinwong",
      "Mitsubishi",
      "Nam Hing",
      "Nanya",
      "Onstatic",
      "Peters",
      "PIC",
      "PTTC",
      "Rogers",
      "ROHM and HAAS",
      "Rongda",
      "Rootlike",
      "Shengyi",
      "Shinemore",
      "Sun Star",
      "SunChemical",
      "Taconic",
      "Taiflex",
      "Taiyo",
      "Tamura",
      "Thinflex",
      "TOYO CHEM",
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
      "Unires Chemicals TW",
      "Yeyo",
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
    expect(DbToCsv.new.to_csv).to eql(data)
  end
end
