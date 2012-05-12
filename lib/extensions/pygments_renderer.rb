class PygmentsRenderer < Redcarpet::Render::HTML
  def block_code( code, language )
    Pygments.highlight( code, :lexer => language, :options => { :encoding => 'utf-8' } )
  end
end
