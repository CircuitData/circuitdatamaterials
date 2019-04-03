require "rails_helper"

RSpec.describe Material do
  subject { build(:material) }

  it { is_expected.to be_valid }
  it "is invalid if the link is invalid" do
    subject.link = "file://something"
    expect(subject).to be_invalid

    subject.link = "http:///something"
    expect(subject).to be_invalid
  end

  it "is valid if the link is valid" do
    subject.link = "http://example.com/something"
    expect(subject).to be_valid

    subject.link = "https://a.b.com/something"
    expect(subject).to be_valid
  end
end
