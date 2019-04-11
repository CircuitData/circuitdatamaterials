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

  scenario "attribute is matched on numerical range" do
    visit "/materials"
    select "dk", from: "Numerical filter"
    fill_in "Min", with: "99"
    fill_in "Max", with: "101"
    click_on "Search"

    expect(page).to have_content("Cheese")
  end

  scenario "attribute does not match on numerical range" do
    visit "/materials"
    select "dk", from: "Numerical filter"
    fill_in "Min", with: "9"
    fill_in "Max", with: "10"
    click_on "Search"

    expect(page).not_to have_content("Cheese")
    expect(page).to have_content("No results")
  end
end
