require 'rails_helper'

describe Roman do
  it "converts arabic numbers to roman numbers" do
    expect(Roman.convert(1)).to eq "I"
    expect(Roman.convert(2)).to eq "II"
    expect(Roman.convert(3)).to eq "III"
    expect(Roman.convert(4)).to eq "IV"
    expect(Roman.convert(10)).to eq "X"
    expect(Roman.convert(11)).to eq "XI"
    expect(Roman.convert(20)).to eq "XX"
    expect(Roman.convert(200)).to eq "CC"
    expect(Roman.convert(3916)).to eq "MMMCMXVI"
    expect(Roman.convert(2614)).to eq "MMDCXIV"
  end
end
