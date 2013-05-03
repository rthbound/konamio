require "minitest_helper"

describe Konamio::Sequence::Requisition do
  before do
    @subject = Konamio::Sequence::Requisition
  end

  it "can be initialized" do
    @subject.must_respond_to :new
  end
end
