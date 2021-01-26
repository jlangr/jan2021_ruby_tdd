require 'rails_helper'

describe Portfolio do
  it 'should be empty if no purchases' do
    expect(subject).to be_empty
  end

  it 'should not be empty if purchases' do
    portfolio = Portfolio.new

    portfolio.purchase

    expect(portfolio).to_not be_empty
  end

  it 'should' do
  end
end
