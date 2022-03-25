class BlogController < ApplicationController
  before_action :set_site_prefix

  def index
    @articles = SimpleBlog.list_articles(params[:tag], params[:in_progress])
  end

  def show
    @article_content_html = SimpleBlog.render_article(params[:id])
  end
end
