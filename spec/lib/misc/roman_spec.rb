require 'rails_helper'

describe Roman do
  it "returns I when given 1" do
    expect(subject.convert(1)).to eq "I"
  end

  it "returns II when given 2" do
    expect(subject.convert(2)).to eq "II"
  end

  it "returns IV when given 4" do
    expect(subject.convert(4)).to eq "IV"
  end

  it "returns V when given 5" do
    expect(subject.convert(5)).to eq "V"
  end
end
