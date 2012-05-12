require "spec_helper"

describe ApplicationHelper do
  describe "markdown" do
    it "should return html safe" do
      helper.markdown("foo").html_safe?.should be_true
    end
  end
end