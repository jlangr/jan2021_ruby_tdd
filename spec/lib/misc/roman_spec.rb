require 'rails_helper'

describe Roman do
  it "converts 1 to I" do
    expect(subject.convert(1)).to eq "I"
  end

  it 'converts 2 to II' do
    expect(subject.convert(2)).to eq "II"
  end

  it 'converts 3 to III' do
    expect(subject.convert(3)).to eq "III"
  end

  it 'converts 4 to IV' do
    expect(subject.convert(4)).to eq "IV"
  end

  it 'converts 5 to V' do
    expect(subject.convert(5)).to eq "V"
  end

  it 'converts 9 to IX' do
    expect(subject.convert(9)).to eq "IX"    
  end

  it 'converts 10 to X' do
    expect(subject.convert(10)).to eq "X"
  end

  it 'converts 20 to XX' do
    expect(subject.convert(20)).to eq "XX"
  end

  it 'converts 30 to XXX' do
    expect(subject.convert(30)).to eq "XXX"
  end

  it 'converts 34 to XXXIV' do
    expect(subject.convert(34)).to eq "XXXIV"
  end

  it 'converts 37 to XXXVII' do
    expect(subject.convert(37)).to eq "XXXVII"
  end

  it 'converts 40 to XL' do
    expect(subject.convert(40)).to eq "XL"
  end

  it 'converts 50 to L' do
    expect(subject.convert(50)).to eq "L"
  end

  it 'converts 90 to XC' do
    expect(subject.convert(90)).to eq "XC"
  end

  it 'converts 100 to C' do
    expect(subject.convert(100)).to eq "C"
  end

  it 'conerts 101 to CI' do
    expect(subject.convert(101)).to eq "CI"
  end

  it 'conerts 110 to CX' do
    expect(subject.convert(110)).to eq "CX"
  end

  it 'conerts 123 to CXXIII' do
    expect(subject.convert(123)).to eq "CXXIII"
  end

  it 'converts 200 to CC' do
    expect(subject.convert(200)).to eq "CC"
  end

  it 'converts 300 to CCC' do
    expect(subject.convert(300)).to eq "CCC"
  end

  it 'converts 400 to CD' do
    expect(subject.convert(400)).to eq "CD"
  end

  it 'converts 500 to D' do
    expect(subject.convert(500)).to eq "D"
  end

  it 'converts 900 to CM' do
    expect(subject.convert(900)).to eq "CM"
  end

  it 'converts 999 to CMXCIX' do
    expect(subject.convert(999)).to eq "CMXCIX"
  end

  it 'converts 1000 to M' do
    expect(subject.convert(1000)).to eq "M"
  end

  it 'converts 2000 to MM' do
    expect(subject.convert(2000)).to eq "MM"
  end

  it 'converts 3000 to MMM' do
    expect(subject.convert(3000)).to eq "MMM"
  end
end
