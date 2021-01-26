require 'rails_helper'

describe Portfolio do
  it 'is empty when created' do
    expect(subject.empty?).to be true
  end

  it 'is not empty when a purchase is made' do
    subject.purchase('AAPL', '30')

    expect(subject.empty?).to be false
  end

  xit 'is empty when all your por' do
  end

  it 'count of symbols is 0 when empty' do
    expect(subject.symbol_count).to eq(0)
  end

  it 'count of symbols is 1 when not empty' do
    subject.purchase('AAPL', '30')

    expect(subject.symbol_count).to eq 1
  end

  it 'has a symbol count greater than one after multiple purchases' do
    subject.purchase('AAPL', '30')
    subject.purchase('AAPL', '30')

    expect(subject.symbol_count).to be > 1
  end

  it 'has a purchase method that accepts symbol and shares as params' do
    expect{subject.purchase('AAPL', '30')}.not_to raise_error
  end

  it 'returns zero when no shares have been purchased for a specific symbol' do
    expect(subject.shares('AAPL')).to eq(0)
  end

  it 'returns the amount of shares for a specific symbol' do
    subject.purchase('AAPL', '30')

    expect(subject.shares('AAPL')).to eq(30)
  end


  xit 'returns the amount of shares for a specific symbol' do
    expect(subject.shares('AAPL')).to eq(40)
  end

end
