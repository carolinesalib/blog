class Article
  def self.build_list_of_articles(articles)
    articles.map do |id, article_content|
      Article.new(id, article_content)
    end
  end

  attr_reader :id, :article_content

  def initialize(id, article_content)
    @id = id
    @article_content = article_content
  end

  def tags
    article_content["tags"].gsub(/\s+/, "").split(",")
  end

  private

  def method_missing(method, *args, &block)
    if article_content[method.to_s]
      self.class.define_method(method.to_s) do
        article_content[method.to_s]
      end

      self.send method, *args, &block
    end
  end
end
