module ApplicationHelper

  def title_render(string)
    content_for(:title) {string}

    html = <<-HTML.html_safe
      <h1> #{string} </h1>
    HTML

    html
  end

  def auth_token
    html = <<-HTML.html_safe
      <input type="hidden"
      name="authenticity_token"
      value="#{form_authenticity_token}">
    HTML
  end
end
