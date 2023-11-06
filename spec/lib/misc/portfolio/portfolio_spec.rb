require 'rails_helper'

APPLE_PRICE = 400
MICROSOFT_PRICE = 100

class StubStockService
  def price(symbol)
    symbol === "AAPL" ? APPLE_PRICE : MICROSOFT_PRICE
  end
end

describe Portfolio do
  #let(:portfolio) { Portfolio.new(StubStockService.new) }
  let(:stock_service) { double }
  let(:portfolio) { Portfolio.new(stock_service) }


  context "when created" do
    it "is empty" do
      expect(portfolio.empty?).to be true
    end

    it "has size 0" do
      expect(portfolio.size).to equal 0
    end

    it "answers 0 for shares of unpurchased symbol" do
      expect(portfolio["AAPL"]).to equal 0
    end

    it "throws when purchasing too many shares" do
      expect { portfolio.sell("AAPL", 1) }.to raise_error(InvalidSaleError)
    end

    it "has value of 0" do
      portfolio.stock_service = StubStockService.new
      expect(portfolio.value()).to eq 0
    end
  end

  context "after purchase" do
    before() do
      portfolio.purchase("AAPL", 42)
    end

    it "is no longer empty" do
      expect(portfolio.empty?).to be false
    end

    it "has size 1" do
      expect(portfolio.size).to equal 1
    end

    it "returns share count for purchased symbol" do
      expect(portfolio["AAPL"]).to equal 42
    end

    it "has value of symbol price" do
      expect(stock_service).to receive(:price).with("AAPL")
                                              .and_return(APPLE_PRICE)

      expect(portfolio.value()).to eq APPLE_PRICE * 42
    end
  end

  context "after multiple purchases different symbols" do
    before() do
      portfolio.purchase("AAPL", 20)
      portfolio.purchase("MSFT", 10)
    end

    it "increments size for each unique symbol" do
      expect(portfolio.size).to equal 2
    end

    it "returns appropriate share count for symbol" do
      expect(portfolio["AAPL"]).to equal 20
    end

    it "sums values for all symbols" do
      allow(stock_service).to receive(:price).with("AAPL")
                                              .and_return(APPLE_PRICE)
      allow(stock_service).to receive(:price).with("MSFT")
                                              .and_return(MICROSOFT_PRICE)

      expect(portfolio.value())
        .to eq 20 * APPLE_PRICE + 10 * MICROSOFT_PRICE
    end
  end

  context "after sale of symbol" do
    before() do
      portfolio.purchase("AAPL", 20)
      portfolio.sell("AAPL", 12)
    end

    it "reduces share count" do
      expect(portfolio["AAPL"]).to equal 20 - 12
    end
  end

  context "after selling all shares of symbol" do
    before() do
      portfolio.purchase("AAPL", 20)
      portfolio.sell("AAPL", 20)
    end

    it "decreases size" do
      expect(portfolio.size).to equal 0
    end
  end

  context "after multiple purchases same symbol" do
    before() do
      portfolio.purchase("AAPL", 20)
      portfolio.purchase("AAPL", 10)
    end

    it "only increments size for each unique symbol" do
      expect(portfolio.size).to equal 1
    end

    it "sums share count" do
      expect(portfolio["AAPL"]).to equal 20 + 10
    end

  end
end
