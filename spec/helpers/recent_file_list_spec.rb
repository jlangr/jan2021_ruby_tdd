require 'rails_helper'

describe RecentFileList do
  let(:list) { RecentFileList.new }

  it "returns files ordered with most recent first" do
    list.open("opened-A")
    list.open("opened-B")
    list.open("opened-C")

    expect(list.filenames).to eq(%w[opened-C opened-B opened-A])
  end

  it "sifts duplicate filename to top" do
    list.open("A")
    list.open("B")
    list.open("C")

    list.open("A")

    expect(list.filenames).to eq(%w[A C B])
  end

  it "sifts duplicate filename to top assert-first" do
    list.open("A")
    list.open("B")
    list.open("C")
    duplicate_of_first_opened = "A"

    list.open(duplicate_of_first_opened)

    expect(list.filenames).to eq([duplicate_of_first_opened, "C", "B"])
  end
end
