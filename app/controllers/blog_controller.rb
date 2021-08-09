require 'redcarpet'
require 'rouge'
require_dependency 'rouge/plugins/redcarpet'

class ArticleHTMLRender < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet

  def block_quote(quote)
    %(<blockquote class="my-custom-class">#{quote}</blockquote>)
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
    # TODO: Click on article to open
    # TODO: Click on tag to filter
  end

  def show
    # TODO: deal with possible errors
    # TODO: Allow to add images (see how I did that with jykill)
    # TODO: Title style
    # TODO: Test mobile
    article_content = File.open("app/articles/#{params[:id]}.md").read
    markdown = Redcarpet::Markdown.new(ArticleHTMLRender, fenced_code_blocks: true)

    @article_content_html = markdown.render(article_content)
  end
end
