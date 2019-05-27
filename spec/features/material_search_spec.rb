require "rails_helper"

RSpec.describe "Searching for a material" do
  let!(:material) {
    create(
      :material,
      name: "Cheese",
      function: "conductive",
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
    expect(page).to have_link("More")
  end

  scenario "Searching with non matching name" do
    visit "/materials"
    fill_in "Material name", with: "chips"
    click_on "Search"

    expect(page).not_to have_content("Cheese")
    expect(page).not_to have_content("Big Pizza")
    expect(page).to have_content("No results")
  end

  scenario "Searching with material function" do
    visit "/materials"
    page.select "Conductive", from: "Material function"
    click_on "Search"

    expect(page).to have_content("Cheese")
    expect(page).to have_content("Big Pizza")
    expect(page).to have_link("More")
  end

  scenario "Searching for non existing material function" do
    visit "/materials"
    page.select "Dielectric", from: "Material function"
    click_on "Search"

    expect(page).to_not have_content("Cheese")
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
    expect(page).to have_content("dk")
    expect(page).to have_content("100")
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
