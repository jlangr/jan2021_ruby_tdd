require 'rails_helper'

describe Portfolio do
  it 'should be empty if no purchases' do
    expect(subject).to be_empty
  end
end
