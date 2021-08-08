require 'redcarpet'

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
    # TODO: highlight code
    # TODO: Allow to add images (see how I did that with jykill)
    # TODO: Test mobile
    article_content = File.open("app/articles/#{params[:id]}.md").read
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

    @article_content_html = markdown.render(article_content)
  end
end
