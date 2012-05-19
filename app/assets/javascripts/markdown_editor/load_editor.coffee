jQuery ->
  if $("#wmd-input").length > 0
    converter = Markdown.getSanitizingConverter()
    editor    = new Markdown.Editor converter
    editor.run()
