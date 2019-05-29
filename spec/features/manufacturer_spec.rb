require "rails_helper"

RSpec.describe "Manufacturers" do
  let!(:manufacturer) { create(:manufacturer, name: "big ost") }
  let!(:material) { create(:material, manufacturer: manufacturer, name: "gouda") }

  it "displays a list of all the manufacturers" do
    visit "/"
    click_on "Manufacturers"

    expect(page).to have_content("big ost")
  end

  it "links to the list of materials associated to the manufacturer" do
    visit "/"
    click_on "Manufacturers"
    click_on "big ost"

    expect(page).to have_select("manufacturer_id", :selected => "big ost")
    expect(page).to have_content("gouda")
  end
end
