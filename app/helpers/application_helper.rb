module ApplicationHelper
  def markdown(text)
    options = [ :hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_codeblock ]
    Redcarpet.new( text, *options ).to_html
  end
end
