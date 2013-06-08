require "minitest_helper"

describe Konamio::Sequence::Listener do
  before do
    @subject = Konamio::Sequence::Listener

    @sequence = "a"
    @input    = MiniTest::Mock.new
  end

  it "can be initialized" do
    @subject.must_respond_to :new
  end

  it "knows when you're right" do
    @input.expect(:getch, "a")
    result = @subject.new(sequence: @sequence, input: @input).execute!

    assert @input.verify
    assert result.successful?
  end

  it "knows when you're wrong" do
    @input.expect(:getch, "b")
    result = @subject.new(sequence: @sequence, input: @input).execute!

    assert @input.verify
    assert !result.successful?
  end

  it "lets you escape" do
    @input.expect(:getch, "\e")
    @input.expect(:getch, "")
    @input.expect(:getch, "")
    result = @subject.new(sequence: @sequence, input: @input).execute!
    assert !result.successful?
  end
end
