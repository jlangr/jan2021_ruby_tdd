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

  xit 'converts 4 to IV' do
    expect(subject.convert(4)).to eq "IV"
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
