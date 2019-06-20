require "rails_helper"

RSpec.describe "Comparing two materials" do
  let(:material1) {
    create(
      :material,
      name: "Cheese",
      manufacturer: manufacturer,
    )
  }
  let(:material2) {
    create(
      :material,
      name: "Bacon",
      manufacturer: manufacturer,
    )
  }
  let(:manufacturer) { create(:manufacturer, name: "Big Pizza") }

  scenario "Name of both materials is displayed" do
    visit "/materials/compare"

    page.all(:fillable_field, 'material_ids[]')[0].set(material1.to_param)
    page.all(:fillable_field, 'material_ids[]')[1].set(material2.to_param)
    click_button("Compare")

    expect(page).to have_content("Cheese")
    expect(page).to have_content("Bacon")
  end
end
