require 'rails_helper'

REPLACE_THIS_WITH_WHAT_THE_REAL_ANSWER_SHOULD_BE = -1

describe 'RSpec' do
  it 'describes basic math' do
<<<<<<< Updated upstream
    expect(4 * 8).to eq(42)
=======
    expect(4 * 8).to eq(32)
>>>>>>> Stashed changes
  end

  it 'describes appending to a list' do
    numbers = [ 12, 1, 1, 1, 2, 1, 3]

    numbers.append(1)

    expect(numbers).to eq([ 12, 1, 1, 1, 2, 1, 3, 1])
  end

  it 'describes transform operations for elements of a list' do
    numbers = [2, 5, 10, 105]

    result = numbers.map { |n| n * 2 }

    expect(result).to eq([4, 10, 20, 210])
  end

  it "describes interesting float point numeric results" do
    result = 0.1 + 0.2

    # fix this expectation so that it appropriately verifies the sum
    expect(result).to be_within(0.001).of(0.3)
  end

  # region nothing to change here
  def replace_this_with_appropriate_code(x) end
  # endregion
end
