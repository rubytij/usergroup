module ApplicationHelper
  def markdown text
    renderer = PygmentsRenderer.new $render_options
    markdown = Redcarpet::Markdown.new renderer, $markdown_extensions
    markdown.render( text ).html_safe
  end

  def current_path
    request.env['PATH_INFO']
  end
end
