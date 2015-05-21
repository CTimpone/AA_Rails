class UserMailer < ActionMailer::Base
  default from: "signup@musicapp.org"

  def activation_email(user)
    @user = user
    @url = "localhost:3000/users/#{user.id}/activate_form?activation_token=#{user.activation_token}"
    mail(to: user.email, subject: 'Welcome, Time to Authenticate')
  end
end
