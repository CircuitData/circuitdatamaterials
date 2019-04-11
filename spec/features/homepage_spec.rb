require "rails_helper"

RSpec.describe "Homepage" do
  it "displays basic information about the DB" do
    visit "/"
    expect(page).to have_link("Material Search")
    expect(page).to have_content("0 materials")
    expect(page).to have_content("0 manufacturers")
  end

  context "manufacturers exist" do
    let!(:manufacturer) { create(:manufacturer, name: "store ost") }

    it "displays a list of all the manufacturers" do
      visit "/"
      expect(page).to have_link("store ost")
    end
  end
end
