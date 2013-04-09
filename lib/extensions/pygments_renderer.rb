class PygmentsRenderer < Redcarpet::Render::HTML
  def block_code( code, language )
    sha = Digest::SHA1.hexdigest( code )

    Rails.cache.fetch [ 'code', language, sha ].join( '-' ) do
      Pygments.highlight( code, lexer: language, options: { encoding: 'utf-8' } )
    end
  end
end
