module ApplicationHelper

  def auth_token
    html = <<-HTML
      <input type="hidden"
             name="authenticity_token"
             value="#{form_authenticity_token}">
    HTML
    html.html_safe
  end

  def sign_out(email)
    html = <<-HTML
      <table>
        <td>
          <a href="#{user_url(User.find_by(email: email))}">#{email}</a>
        </td>
        <td>
          <form action="#{session_url}" method="post">
            <input type="hidden" name="_method" value="delete">
            #{auth_token}

            <button>Sign-Out</button>
          </form>
        </td>
      </table>
    HTML

    html.html_safe
  end

  def sign_in
    html = <<-HTML
      <table>
        <td>
          <form action="#{new_session_url}" method="get">
            #{auth_token}

            <button>Sign-In</button>
          </form>
        </td>
        <td>
          <form action="#{new_user_url}" method="get">
            #{auth_token}

            <button>Sign-Up</button>
          </form>
        </td>
      </table>
    HTML

    html.html_safe
  end
end
