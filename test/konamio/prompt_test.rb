require "minitest_helper"

describe Konamio::Prompt do
  before do
    @subject = Konamio::Prompt
  end

  it "can be initialized" do
    @subject.must_respond_to :new
  end
end
