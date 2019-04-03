require "rails_helper"

RSpec.describe "Datasheet download" do
  let(:manufacturer) { create(:manufacturer, name: "arlon") }
  let(:material) {
    create(
      :material,
      manufacturer: manufacturer,
      name: material_name,
      link: "http://example.com",
    )
  }

  context "datasheet is present" do
    let(:material_name) { "47n" }

    scenario "the datasheet can be downloaded" do
      visit datasheet_material_path(material)
      expect(page.body).not_to be_empty
      expect(page.body).to start_with("%PDF-1.6")
    end
  end

  context "datasheet is not present" do
    let(:material_name) { "not a real one" }

    scenario "a message is displayed" do
      visit datasheet_material_path(material)

      expect(page).to have_content("No datasheet available.")
      expect(page).to have_content("It may be available at: http://example.com")
      expect(page).to have_content("If the datasheet is available let us know!")
    end
  end
end
