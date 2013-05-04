require "minitest_helper"

describe Konamio::KeyMap do
  before do
    @subject = Konamio::KeyMap
  end

  it "returns the input provided if no matches are found" do
    assert @subject.sequence(:konami) == :konami
  end

  it "recognizes a number of symbols" do
    [
      :up,
      :down,
      :left,
      :right,
      :space,
      :tab,
      :return,
      :line_feed,
      :escape
    ].each do |symbol|
      assert @subject.sequence(symbol) != symbol
    end
  end
end

