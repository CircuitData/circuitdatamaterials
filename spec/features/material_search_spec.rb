require "rails_helper"

RSpec.describe "Searching for a material" do
  let!(:material) {
    create(
      :material,
      name: "Cheese",
      manufacturer: manufacturer,
      dk: 100,
    )
  }
  let(:manufacturer) { create(:manufacturer, name: "Big Pizza") }

  scenario "Searching with name prefix" do
    visit "/materials"
    fill_in "Material name", with: "chee"
    click_on "Search"

    expect(page).to have_content("Cheese")
    expect(page).to have_content("Big Pizza")
  end
end
