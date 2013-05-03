require "minitest_helper"

describe Konamio::Prompt do
  before do
    @subject = Konamio::Prompt
    @prompt  = rand(100000).to_s
    @output   = MiniTest::Mock.new

    @output.expect(:puts, nil, [@prompt])
  end

  it "can be initialized" do
    @subject.must_respond_to :new
    prompted = @subject.new(prompt: @prompt, output: @output).execute!
    assert prompted.successful?
    assert @output.verify
  end
end
