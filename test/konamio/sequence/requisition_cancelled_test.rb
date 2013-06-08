require "minitest_helper"

describe Konamio::Sequence::Requisition do
  before do
    @subject = Konamio::Sequence::Requisition
    @options = {
      input:    @input            = MiniTest::Mock.new,
      output:   @output           = MiniTest::Mock.new,
      prompt:   @prompt           = false,
      listener: @listener         = MiniTest::Mock.new,
      speaker:  @speaker          = MiniTest::Mock.new,
      sequence: @sequence         = "ab",
      confirmation: @confirmation = false,
      cancellation: false
    }

    # We will call new on @listener and return
    @listener_instance = MiniTest::Mock.new
    @listener.expect(:new, @listener_instance, [{ sequence: @sequence, input: @input }])

    # We will call execute! on the @listener_instance and return
    @listener_result   = MiniTest::Mock.new
    @listener_instance.expect(:execute!, @listener_result)

  end

  it "can be initialized" do
    @subject.must_respond_to :new
  end

  it "must execute" do
    @subject.new(@options).must_respond_to :execute!
  end

  it "can be cancelled" do
    # The @listener_result contains some data
    @data_hash = MiniTest::Mock.new
    @listener_result.expect(:data, @data_hash)
    @data_hash.expect(:[], :negative, [:sequence])

    assert !@subject.new(@options).execute!.successful?
  end

  it "will listen for the next character" do
    # This will happen a second time
    @listener.expect(:new, @listener_instance, [{ sequence: "b", input: @input }])
    @listener_instance.expect(:execute!, @listener_result)

    # The @listener_result contains some data
    @data_hash = MiniTest::Mock.new
    @listener_result.expect(:data, @data_hash)
    @data_hash.expect(:[], "b", [:sequence])

    @listener_result.expect(:data, @data_hash)
    @data_hash.expect(:[], :negative, [:sequence])

    assert !@subject.new(@options).execute!.successful?
  end
end
