require 'rails_helper'

describe Portfolio do
  it 'is empty when created' do
    expect(subject.empty?).to be true
  end

  it 'is not empty when a purchase is made' do
    subject.purchase

    expect(subject.empty?).to be false
  end

  xit 'is empty when all your por' do
  end

  it 'count of symbols is 0 when empty' do
    expect(subject.symbol_count).to eq(0)
  end

  it 'count of symbols is 1 when not empty' do
    subject.purchase

    expect(subject.symbol_count).to eq 1
  end

  it 'has a symbol count greater than one after multiple purchases' do
  end

end
