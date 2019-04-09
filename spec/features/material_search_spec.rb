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

  scenario "Searching with non matching name" do
    visit "/materials"
    fill_in "Material name", with: "chips"
    click_on "Search"

    expect(page).not_to have_content("Cheese")
    expect(page).not_to have_content("Big Pizza")
    expect(page).to have_content("No results")
  end
end
