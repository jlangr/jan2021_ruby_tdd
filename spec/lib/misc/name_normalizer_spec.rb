require 'rails_helper' # hack to allow running in RubyMine as individual spec

RSpec.describe NameNormalizer, type: :helper do
  it "returns the empty string when passed an empty string" do
    expect(subject.normalize "").to eq ""
  end

  it "returns a monomym when passed one" do
    expect(subject.normalize "Plato").to eq "Plato"
  end

  it "swaps first and last names" do
    expect(subject.normalize "Haruki Murakami").to eq "Murakami, Haruki"
  end

  it "trims leading and trailing whitespace" do
    expect(subject.normalize "   Big Boi    ").to eq "Boi, Big"
  end

  it "initializes middle name" do
    expect(subject.normalize "Henry David Thoreau").to eq "Thoreau, Henry D."
  end

   it "does not initialize one-letter middle name" do
     expect(subject.normalize "Harry S Truman").to eq "Truman, Harry S"
   end

   it "initializes each of multiple middle names" do
     expect(subject.normalize "Julia Scarlett Elizabeth Louis-Dreyfus").to eq "Louis-Dreyfus, Julia S. E."
   end

  it "appends suffixes to end" do
    expect(subject.normalize "Martin Luther King, Jr.").to eq "King, Martin L., Jr."
  end
  #
  # xit "throws when name contains too many commas" do
  #   expect { subject.normalize "Thurston, Howell, III" }.to raise_error(ArgumentError)
  # end
end
