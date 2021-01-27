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

    expect(subject.symbols).to eq([symbol])
  end

  it 'should record multiple symbols' do
    apple_symbol = 'APPL'
    tesla_symbol = 'TSLA'

    subject.purchase(apple_symbol, 1)
    subject.purchase(tesla_symbol, 1)

    expect(subject.symbols).to include(apple_symbol, tesla_symbol)
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

    expect(subject.purchases).to eql({apple_symbol => 10})
  end

  it 'should increment shares with multiple purchases' do
    apple_symbol = 'APPL'

    subject.purchase(apple_symbol, 10)
    subject.purchase(apple_symbol, 10)

    expect(subject.purchases).to eql({apple_symbol => 20})
  end

  it 'should return 0 if symbol has not been purchased' do
    expect(subject.shares_of('APPL')).to eql(0)
  end

  it 'should return shares if symbol has been purchased' do
    subject.purchase('APPL', 10)

    expect(subject.shares_of('APPL')).to eq(10)
  end

  it 'should reduce the number of shares in the portfolio when selling' do
    subject.purchase('APPL', 20)
    subject.sell('APPL', 5)

    expect(subject.shares_of('APPL')).to eql(15)
  end
end
