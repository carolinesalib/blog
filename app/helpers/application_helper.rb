module ApplicationHelper
  class ArticleHTMLRender < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet

    def block_quote(quote)
      %(<blockquote class="my-custom-class">#{quote}</blockquote>)
    end
  end
end
