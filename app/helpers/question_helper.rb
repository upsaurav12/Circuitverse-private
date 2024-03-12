module QuestionHelper
    def markdown(text)
        return '' if text.nil?
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
        markdown.render(text).html_safe
      end
end
