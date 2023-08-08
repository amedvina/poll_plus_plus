require 'rails_helper'

RSpec.describe "posts/show.html.erb", type: :view do
  before do
    assign(:post, double("Post", title: "Example Title", content: "Hi, **this is a test**!"))
  end

  it "displays the post title" do
    render

    expect(rendered).to have_selector("h1", text: "Example Title")
  end

  it "renders the post content using rendered_content helper" do
    markdown_html = "markdown content"
    allow(view).to receive(:rendered_content).with("Hi, **this is a test**!").and_return(markdown_html)

    render

    expect(rendered).to have_text("markdown content")
  end
end
