require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  describe "#rendered_content" do
    it "renders the content in markdown" do
      input = "Hi, **this is a test**!"
      expected_output = "<p>Hi, <strong>this is a test</strong>!</p>\n"

      rendered_html = helper.rendered_content(input)

      expect(rendered_html).to eq(expected_output)
    end

    it "escapes scripting attacks" do
      text = "<script>alert('Hi!');</script>"

      rendered_html = helper.rendered_content(text)

      expect(rendered_html).to_not have_selector("script")
      expect(rendered_html).to have_selector("p")
    end
  end
end