require "rails_helper"

RSpec.describe "Homepage" do
  it "displays basic information about the DB" do
    visit "/"
    expect(page).to have_link("Material Search")
    expect(page).to have_link("Manufacturers")
    expect(page).to have_content("0 materials")
    expect(page).to have_content("0 manufacturers")
  end

  context "db entries exist" do
    let!(:manufacturer) { create(:manufacturer, name: "store ost") }
    let!(:material) { create(:material, manufacturer: manufacturer) }

    it "displays a list of all the manufacturers" do
      visit "/"
      expect(page).to have_content("1 materials")
      expect(page).to have_content("1 manufacturers")
    end
  end

  it "allows the CSV to be downloaded" do
    visit "/"
    click_on("CSV")

    expect(page.body).to eql(File.read(Rails.root.join("lib", "data", "materials.csv")))
  end
end
