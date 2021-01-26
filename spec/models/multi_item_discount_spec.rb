require 'rails_helper'

RSpec.describe MultiItemDiscount, type: :model do
  describe "validations" do
    it { should validate_presence_of(:upc) } #shoulda matcher  https://github.com/thoughtbot/shoulda-matchers
    it { is_expected.to validate_presence_of(:upc) }  #also, in case you like this better

    it { should validate_presence_of(:discount_at_required) }
    it { should validate_numericality_of(:discount_at_required).only_integer }

    # it { should validate_presence_of(:required_for_discount) }
    # it { should validate_numericality_of(:required_for_discount)
    #      .only_integer
    #      .is_less_than(5) }
  end

  # TODO remove UPC?

  describe("discounting") do
    it "discounts 2nd item of bogo" do
      discount = MultiItemDiscount.new(upc: "123", required_for_discount: 2, discount_at_required: 1.0)
      items = [{ upc: "123", price: 2.00}, {upc: "123", price: 2.00}]

      result = discount.price(items)

      expect(result).to eq(
        [{upc: "123", price: 2.00, rendered_price: 2.00}, {upc: "123", price: 2.00, rendered_price: 0.00}])
    end
  end
end
