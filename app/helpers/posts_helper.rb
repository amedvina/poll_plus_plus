module PostsHelper
  def rendered_content(text)
    renderer = Redcarpet::Render::HTML.new(filter_html: true)
    markdown = Redcarpet::Markdown.new(renderer)

    markdown.render(text).html_safe
  end
end
