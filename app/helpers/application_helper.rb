module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(excape_html: true)

    markdown = Redcarpet::Markdown.new(renderer,
                                       no_intra_emphasis: true,
                                       fenced_code_blocks: true,
                                       disable_indented_code_blocks: true,
                                       autolink: true,
                                       tables: true,
                                       underline: true,
                                       highlight: true
                                      )
    return markdown.render(text).html_safe if text
  end
end
