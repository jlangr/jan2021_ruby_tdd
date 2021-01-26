require 'rails_helper'

RSpec.describe BetterPortfolio do
  describe '#empty?' do
    it 'returns true when created' do
      expect(subject).to be_empty
    end

    it 'returns false after a purchase' do
      subject.purchase

      expect(subject).to_not be_empty
    end
  end
end