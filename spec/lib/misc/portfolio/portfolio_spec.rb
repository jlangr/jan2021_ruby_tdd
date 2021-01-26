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

  it 'count of symbols is 1 when not empty' do
    expect(subject.symbol_count).to eq 1
  end

end
