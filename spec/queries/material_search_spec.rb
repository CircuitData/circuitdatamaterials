require "rails_helper"

RSpec.describe MaterialSearch do
  subject { described_class.new(params) }
  describe "#has_valid_params?" do
    context "params are empty" do
      let(:params) { {} }
      it { is_expected.not_to have_valid_params }
    end

    context "name is present" do
      let(:params) { { material_name: "yes" } }
      it { is_expected.to have_valid_params }
    end

    context "only numerical filter is present" do
      let(:params) { { numerical_filter: "dk" } }
      it { is_expected.not_to have_valid_params }
    end

    context "only min is present" do
      let(:params) { { min: "10" } }
      it { is_expected.not_to have_valid_params }
    end

    context "only max is present" do
      let(:params) { { min: "10" } }
      it { is_expected.not_to have_valid_params }
    end
    context "valid min query is present" do
      let(:params) { { numerical_filter: "dk", min: "10" } }
      it { is_expected.to have_valid_params }
    end

    context "invalid min query is present" do
      let(:params) { { numerical_filter: "pizza", min: "10" } }
      it { is_expected.not_to have_valid_params }
    end

    context "valid max query is present" do
      let(:params) { { numerical_filter: "dk", max: "10" } }
      it { is_expected.to have_valid_params }
    end
  end

  describe "#results" do
    let!(:material_1) { create(:material, name: "Tasty Pizza", dk: 10) }
    let!(:material_2) { create(:material, name: "Not Pizza", dk: 20) }

    it "returns results matching name" do
      r = results(material_name: "Pizza")
      expect(r).to match([material_1, material_2])

      r = results(material_name: "pizza")
      expect(r).to match([material_1, material_2])

      r = results(material_name: "tasty")
      expect(r).to match([material_1])
    end

    it "returns results with correct min value" do
      r = results(numerical_filter: "dk", min: "10")
      expect(r).to match([material_1, material_2])

      r = results(numerical_filter: "dk", min: "20")
      expect(r).to match([material_2])

      r = results(numerical_filter: "dk", min: "21")
      expect(r).to match([])
    end

    it "returns results with correct min  and max value" do
      r = results(numerical_filter: "dk", min: "10", max: "20")
      expect(r).to match([material_1, material_2])

      r = results(numerical_filter: "dk", min: "20", max: "21")
      expect(r).to match([material_2])

      r = results(numerical_filter: "dk", min: "21", max: "22")
      expect(r).to match([])
    end
  end

  def results(params)
    described_class.new(params).results
  end
end
