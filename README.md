# Blog

## Introduction
After using jekyll for some time, I decided to create my own blog from scratch so I would understand what are the challenges and also be able to customize the way I want without searching for plugins or including workarounds.

First I thought this should be a private project, but maybe there are other people out there that wants to do the same and need some inspiration, so now this project is open source.

Here is the URL of my blog in production if you want to take a look: http://carolinesalib.com

## Tech
* Ruby version: 3.0.0
* Rails version: 6.1.3

## Usage
It should be as simple as:
```shell
bundle install
rails server
```

## How it works

### About page
Simple page with some information about the writter.

### Blog page

**Storing and editing articles**

With the intent of making it as simple as possible, I decided to not use a database for now. Instead, I'm saving the articles on markdown files under `articles` folder. This way I can easily edit my markdowns without needing a whole admin area where I can edit and preview my articles.

The `Article` model (not an active record model) is responsible for converting the `article.yml` structure into a list of articles to be displayed at `/blog/posts` URL.

I'm using the `redcarpet` gem to parse the markdown files and `rouge` gem for code highlight.

**Filters**

In the `/blog/posts` URL, we can search for tags (ex: `/blog/posts?tag=ruby`) or for articles in progress (ex: `/blog/posts?in_progress=true`). Articles in progress are hidden in the main list unless we use the `in_progress` param in the URL.

**Slug**

Slugs are really simple in this application.

* URL without slug: http://localhost:3000/blog/posts/1
* URL with slug: http://localhost:3002/blog/posts/1-how-to-debug-ruby-tasks-on-rubymine

The articles are saved with a numeric identification (ex: `1.md, 2.md`) in the `articles` folder. The easiest way to implement a slug is to parameterize the title of the article, ex:
```ruby
  blog_post_path("#{article.id}-#{article.title.parameterize}")
```
On the `blog_controller.rb` file I just need to convert the `id` param to `int` in order to get the id.
```ruby
File.open("app/articles/#{params[:id].to_i}.md")
```

### Contribution
If you have any questions, suggestions or comments about this project feel free to open an issue or submit a pull request.
