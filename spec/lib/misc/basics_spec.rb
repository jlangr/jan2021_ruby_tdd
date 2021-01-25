require 'rails_helper'

REPLACE_THIS_WITH_WHAT_THE_REAL_ANSWER_SHOULD_BE = -1

describe 'RSpec' do
  xit 'describes basic math' do
    expect(4 * 8).to eq(REPLACE_THIS_WITH_WHAT_THE_REAL_ANSWER_SHOULD_BE)
  end

  xit 'describes appending to a list' do
    numbers = [ 12, 1, 1, 1, 2, 1, 3]

    numbers.append(1)

    expect(numbers).to eq(REPLACE_THIS_WITH_WHAT_THE_REAL_ANSWER_SHOULD_BE)
  end

  xit 'describes transform operations for elements of a list' do
    numbers = [2, 5, 10, 105]

    result = replace_this_with_appropriate_code(numbers)

    expect(result).to eq([4, 10, 20, 210])
  end

  xit "describes interesting float point numeric results" do
    result = 0.1 + 0.2

    # fix this expectation so that it appropriately verifies the sum
    expect(result).to eq 0.3
  end

  # region nothing to change here
  def replace_this_with_appropriate_code(x) end
  # endregion
end
