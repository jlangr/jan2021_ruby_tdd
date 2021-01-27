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

  it "returns X when given 10" do
    expect(subject.convert(10)).to eq "X"
  end

  it "returns XIV when given 14" do
    expect(subject.convert(14)).to eq "XIV"
  end

  it "returns XV when given 15" do
    expect(subject.convert(15)).to eq "XV"
  end

  it "returns XX when given 20" do
    expect(subject.convert(20)).to eq "XX"
  end

  it "returns L when given 50" do
    expect(subject.convert(50)).to eq "L"
  end

  it "returns XC when given 90" do
    expect(subject.convert(90)).to eq "XC"
  end

  it "returns C when given 100" do
    expect(subject.convert(100)).to eq "C"
  end

  it "returns CD when given 400" do
    expect(subject.convert(400)).to eq "CD"
  end

  it "returns M when given 1000" do
    expect(subject.convert(1000)).to eq "M"
  end
end
