require "rails_helper"

RSpec.describe "Comparing two materials" do
  let(:material1) {
    create(
      :material,
      name: "Cheese"
    )
  }
  let(:material2) {
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
end
