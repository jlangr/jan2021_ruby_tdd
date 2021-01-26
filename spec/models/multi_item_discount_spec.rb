require 'rails_helper'

RSpec.describe MultiItemDiscount, type: :model do

  describe "validations" do
    it { should validate_presence_of(:upc) } #shoulda matcher  https://github.com/thoughtbot/shoulda-matchers
    it { is_expected.to validate_presence_of(:upc) }  #also, in case you like this better
  end

  describe("discounting BOGO") do
    subject(:discount) { MultiItemDiscount.create(upc: "123", required_for_discount: 2, discount_at_required: 1.0) }
    before(:context) do
      create(:item, upc: "123", price: 2.00)
    end

    it "discounts 2nd item of bogo" do
      result = discount.price_last([{ upc: "123"}, {upc: "123"}])

      expect(result).to eq({upc: "123", price: 2.00, rendered_price: 0.00})
    end

    it "ignores items without matching UPCs" do
      result = discount.price_last([{ upc: "123"}, {upc: "XXX"}, {upc: "123"}])

      expect(result).to eq({upc: "123", price: 2.00, rendered_price: 0.00})
    end

    it "does not discount 3rd item" do
      result = discount.price_last([{ upc: "123"}, {upc: "123"}, {upc: "123"}])

      expect(result).to eq({upc: "123", price: 2.00, rendered_price: 2.00})
    end

    it "does discount 4th item" do
      items = [{ upc: "123"}, {upc: "123"}, {upc: "123"}, {upc: "123"}]

      result = discount.price_last(items)

      expect(result).to eq({upc: "123", price: 2.00, rendered_price: 0.00})
    end
  end
end
