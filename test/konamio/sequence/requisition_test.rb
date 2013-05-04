require "minitest_helper"

describe Konamio::Sequence::Requisition do
  before do
    @subject = Konamio::Sequence::Requisition
    @options = {
      prompt: "Foo diddly doobardy party hardy",
      listener: @listener = MiniTest::Mock.new,
      sequence: "a",
      speaker:  @speaker  = MiniTest::Mock.new,
      confirmation: "Good job, you."
    }
  end

  it "can be initialized" do
    @subject.must_respond_to :new
  end

  it "returns a result object" do
  end
end
