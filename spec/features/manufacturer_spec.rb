require "rails_helper"

RSpec.describe "Manufacturers" do
  let!(:manufacturer) { create(:manufacturer, name: "big ost") }

  it "displays a list of all the manufacturers" do
    visit "/"
    click_on "Manufacturers"

    expect(page).to have_content("big ost")
  end
end
