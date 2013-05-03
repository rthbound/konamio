require "minitest_helper"

describe Konamio::Sequence::Listener do
  before do
    @subject = Konamio::Sequence::Listener
  end

  it "can be initialized" do
    @subject.must_respond_to :new
  end
end
