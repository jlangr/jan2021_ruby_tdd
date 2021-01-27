require 'rails_helper'

describe Portfolio do
  it 'is empty when created' do
    expect(subject.empty?).to be true
  end

  it 'is not empty when a purchase is made' do
    subject.purchase('AAPL', 30)

    expect(subject.empty?).to be false
  end

  it 'count of symbols is 0 when empty' do
    expect(subject.symbol_count).to eq(0)
  end

  it 'count of symbols is 1 when not empty' do
    subject.purchase('AAPL', 30)

    expect(subject.symbol_count).to eq 1
  end

  it 'has a symbol count stays the same after multiple purchases of the same stock' do
    subject.purchase('AAPL', 30)
    subject.purchase('AAPL', 30)

    expect(subject.symbol_count).to eq(1)
  end

  it 'has a symbol count of 2 when you purchase two different stocks' do
    subject.purchase('AAPL', 30)
    subject.purchase('BBA', 30)

    expect(subject.symbol_count).to eq(2)
  end

  it 'has a purchase method that accepts symbol and shares as params' do
    expect{subject.purchase('AAPL', 30)}.not_to raise_error
  end

  it 'returns zero when no shares have been purchased for a specific symbol' do
    expect(subject.shares('AAPL')).to eq(0)
  end

  it 'returns the amount of shares for a specific symbol' do
    subject.purchase('AAPL', 30)

    expect(subject.shares('AAPL')).to eq(30)
  end

  it 'has a method to return the amount of shares for a specific symbol after you make a purchaes for a differen symbol' do
    subject.purchase('AAPL', 30)
    subject.purchase('BBA', 40)

    expect(subject.shares('BBA')).to eq(40)
  end

  it 'return the correct number of shares when same stock is purchased twice' do
    subject.purchase('AAPL', 30)
    subject.purchase('AAPL', 40)

    expect(subject.shares('AAPL')).to eq(70)
  end

end
