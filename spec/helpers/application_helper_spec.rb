require "spec_helper"

describe ApplicationHelper do
  describe "markdown" do
    let(:markdown) { "hello\nworld `Code sample`" }
    let(:expected_html) { "<p>hello<br>\nworld <code>Code sample</code></p>\n" }

    it "should return html safe" do
      helper.markdown( markdown ).should be_html_safe
    end

    it "should turn markdown to html" do
      helper.markdown( markdown ).should eql( expected_html )
    end
  end
end
