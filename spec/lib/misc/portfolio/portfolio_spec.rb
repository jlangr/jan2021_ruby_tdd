require 'rails_helper'

describe Portfolio do
  it 'should be empty if no purchases' do
    expect(subject).to be_empty
  end

  it 'should not be empty if purchases' do
    subject.purchase("APPL")

    expect(subject).to_not be_empty
  end

  it 'should record a symbol' do
    symbol = "APPL"

    subject.purchase(symbol)

    expect(subject.symbols).to eq(symbol)
  end
end
