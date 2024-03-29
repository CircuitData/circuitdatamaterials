require "rails_helper"

RSpec.describe "Viewing a material" do
  let(:material) {
    create(
      :material,
      name: "Cheese",
      manufacturer: manufacturer,
    )
  }
  let(:manufacturer) { create(:manufacturer, name: "Big Pizza") }

  scenario "Name and manufacturer is displayed" do
    visit "/materials/#{material.to_param}"

    expect(page).to have_content("Cheese")
    expect(page).to have_content("Big Pizza")
  end

  scenario "All attributes for all functions are displayed" do
    default = MaterialsHelper::DEFAULT_ATTRIBUTES
    MaterialsHelper::MATERIAL_ATTRIBUTES.each do |function, attrs|
      material = create(
        :material,
        name: "Cheese-"+function,
        manufacturer: manufacturer,
        function: function
      )
      visit "/materials/#{material.to_param}"
      attrs+default.each do |attr|
        expect(page).to have_content(attr.humanize)
      end
    end
  end
end
