require 'rails_helper'

require 'date'

class GreenerGrass
  attr_accessor :answer

  def homebody_method(some_value)
    result = do_stuff(@some_self_value)
    do_more_stuff(result)
    @answer
  end

  def do_stuff(some_value) end

  def do_more_stuff(some_result) end
end

class WrongPlace2
  def initialize
    @some_self_value = 42
  end

  def some_public_behavior
    result = GreenerGrass.new
                         .homebody_method(@some_self_value)
    # ...
  end
end

class WrongPlace
  def initialize
    @some_self_value = 42
  end

  def some_public_behavior
    result = some_envious_method
    # ...
  end

  private

  def some_envious_method
    there = GreenerGrass.new
    result = there.do_stuff(@some_self_value)
    there.do_more_stuff(result)
    there.answer
  end
end

class Auto
  attr_reader :RPM

  def depress_brake
    # code here
  end

  def press_start_button
    @RPM = 1000
  end
end

describe Auto do
  let(:auto) { Auto.new }

  it "idles engine when started" do
    auto.depress_brake

    auto.press_start_button

    expect(auto.RPM).to be_between(950, 1100)
  end
end

describe TargetClass do
  let(:sut) { TargetClass.new }

  it "provides some behavior" do
    # Arrange

    # Act

    # Assert
  end

  it "rspec matchers" do
    condition = true
    something = "expected text"
    some_collection = []
    obj = Auto.new

    expect(condition).to be true
    expect(something).to eq "expected text"
    expect(something).not_to eq "unexpected text"
    expect("technology").to include "tech"
    expect("something").to match /.*thing$/
    expect { 4 / 0 }.to raise_error(ZeroDivisionError)
    expect(some_collection).to be_empty
    expect(obj).to be_instance_of(Auto)
    expect([12, 1, 1, 1, 2, 1, 3]).to include(12, 3)
    expect([2, 4, 8, 16, 32]).to all(be_even.and be < 64)
  end
end

describe "given some context" do
  describe "when some event occurs" do
    it "then can be verified" do

    end
  end
end

Agile_Java = "Agile Java"
Patron_Id = 1

class Library
  def borrow(a, b)
    return DateTime.new(2021, 1, 20)
  end

  def return_material(x, y) end

  def available?(m)
    true
  end
end

describe "exception handling" do
  it("does stuff") do
    expect {
      t = TargetClass.new
      t.handle_something
    }.to raise_error(StandardError)
  end

  it("does else stuff") do
    expect {
      t = TargetClass.new
      t.handle_something_else
    }.to raise_error(StandardError)
  end

  it("does repetition stuff") do
    expect {
      t = TargetClass.new
      t.handle_with_function_argument
    }.to raise_error(StandardError)
  end
end

describe('given a checked-out material') do
  let(:library) { Library.new }

  before(:each) do
    @due_date = library.borrow(Agile_Java, Patron_Id)
  end

  describe 'when returned late' do
    before(:each) do
      library.return_material(Agile_Java, @due_date + 1)
    end

    it 'is marked as available' do
      expect(library.available? Agile_Java).to be true
    end

    it 'generates a late fine' do
      # ...
    end

    it 'notifies patrons with hold' do
      # ...
    end
  end

  describe Dictionary do
    let(:dictionary) { Dictionary.new }
    let(:auditor_spy) { spy("auditor") }

    before(:each) do
      dictionary.auditor = auditor_spy
    end

    it "allows adding words" do
      dictionary.auditor = auditor_spy
      dictionary.add("smelt", "a small fish")
      expect(dictionary.definition("smelt")).to eq "a small fish"
    end

    it "logs audit record on add" do
      auditor_spy = spy("auditor")
      dictionary.auditor = auditor_spy
      dictionary.add("smelt", "a small fish")
      expect(auditor_spy).to have_received(:log).with("added to dictionary")
    end
  end
end

