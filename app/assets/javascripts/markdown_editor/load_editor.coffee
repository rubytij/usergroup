$ ->
  converter = Markdown.getSanitizingConverter()
  editor    = new Markdown.Editor converter
  editor.run()
