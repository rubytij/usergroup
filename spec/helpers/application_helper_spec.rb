require "spec_helper"

describe ApplicationHelper do
  describe "markdown" do
    before :each do
      @markdown       = "hello\nworld `Code sample`"
      @expected_html  = "<p>hello<br>\nworld <code>Code sample</code></p>\n"
    end

    it "should return html safe" do
      helper.markdown( @markdown ).should be_html_safe
    end

    it "should turn markdown to html" do
      helper.markdown( @markdown ).should eql( @expected_html )
    end
  end
end
