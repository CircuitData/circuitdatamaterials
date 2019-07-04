require "rails_helper"

RSpec.describe "Comparing two materials" do
  let!(:material1) {
    create(
      :material,
      name: "Cheese",
    )
  }

  let!(:material2) {
    create(
      :material,
      name: "Bacon"
    )
  }

  scenario "Name of both materials is displayed" do
    visit "/materials/"+material1.to_param
    click_button("Add To Compare")
    visit "/materials/"+material2.to_param
    click_button("Add To Compare")

    visit "/materials/compare"

    expect(page).to have_content("Cheese")
    expect(page).to have_content("Bacon")
  end

  scenario "Materials can be added from search" do
    visit "/materials"
    fill_in "Material name", with: "chee"
    click_on "Search"
    expect(page).to have_content("Cheese")
    click_button("Add To Compare")

    visit "/materials/compare"

    expect(page).to have_content("Cheese")
  end

end
