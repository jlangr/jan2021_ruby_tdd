require 'rails_helper'

RSpec.describe MultiItemDiscount, type: :model do
  describe "validations" do
    it { should validate_presence_of(:upc) }
    it { is_expected.to validate_presence_of(:upc) } # alternate form
  end

  describe "discounting" do
  end
end
