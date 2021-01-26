require 'rails_helper'

describe Portfolio do
  it 'should be empty if no purchases' do
    expect(subject).to be_empty
  end

  it 'should not be empty if purchases' do
    subject.purchase("APPL", 1)

    expect(subject).to_not be_empty
  end

  it 'should record a symbol' do
    symbol = "APPL"

    subject.purchase(symbol, 1)

    expect(subject.symbols).to eq([symbol.to_sym])
  end

  it 'should record multiple symbols' do
    apple_symbol = 'APPL'
    tesla_symbol = 'TSLA'

    subject.purchase(apple_symbol, 1)
    subject.purchase(tesla_symbol, 1)

    expect(subject.symbols).to include(apple_symbol.to_sym, tesla_symbol.to_sym)
  end

  it 'should not duplicate mulitiple symbols when multiple purchases of same symbol' do
    apple_symbol = 'APPL'
    tesla_symbol = 'TSLA'

    subject.purchase(apple_symbol, 1)
    subject.purchase(tesla_symbol, 1)
    subject.purchase(apple_symbol, 1)

    expect(subject.symbols.count).to eq(2)
  end

  it 'should record share counts' do
    apple_symbol = 'APPL'

    subject.purchase(apple_symbol, 10)

    expect(subject.purchases).to eql({'APPL': 10})
  end
end
