require "minitest_helper"

describe Konamio::KeyMap do
  before do
    class TestCase
      include Konamio::KeyMap
    end

    @subject = TestCase.new
  end

  it "returns the input provided if no matches are found" do
    assert @subject.sequence_for(:konamio) == :konamio
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
      :escape,
      :konami
    ].each do |symbol|
      assert @subject.sequence_for(symbol) != symbol
    end
  end
end

