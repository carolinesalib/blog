require 'redcarpet'
require 'rouge'
require_dependency 'rouge/plugins/redcarpet'

# TODO: move this to a better place
class ArticleHTMLRender < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
  include ActionView::Helpers::AssetTagHelper

  def image(link, title, alt_text)
    if title =~ /=(\d+)x(\d+)/
      %(<img src="#{ActionController::Base.helpers.asset_path(link)}" alt="#{alt_text}" class="markdown-image" style="max-width: #{$1}px; max-height:#{$2}px">)
    else
      %(<img src="#{ActionController::Base.helpers.asset_path(link)}" alt="#{alt_text}" class="markdown-image">)
    end
  end
end

class BlogController < ApplicationController
  before_action :set_site_prefix

  def index
    articles_yml_result = YAML.load_file("app/articles/articles.yml")["articles"]
    @articles = Article.build_list_of_articles(articles_yml_result)

    if params[:tag].present?
      @articles = @articles.filter { |article| article.tags.include?(params[:tag]) }
    end
  end

  def show
    # TODO: deal with possible errors
    # TODO: Test mobile
    # TODO: slug
    article_content = File.open("app/articles/#{params[:id]}.md").read
    markdown = Redcarpet::Markdown.new(ArticleHTMLRender, fenced_code_blocks: true)

    @article_content_html = markdown.render(article_content)
  end
end
