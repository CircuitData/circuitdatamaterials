require "rails_helper"

RSpec.describe "Linting" do
  it "checks that all models have a factory" do
    Rails.application.eager_load!
    models = ApplicationRecord.descendants.map(&:name).map(&:underscore)
    models.each do |model|
      FactoryBot.create(model.to_sym)
    end
  end

  it "checks that all factories are valid" do
    FactoryBot.lint verbose: true
  end

  it "ensures that the seeds are working properly" do
    require_relative "../../db/seeds"
  end
end
