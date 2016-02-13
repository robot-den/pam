class UserMailer < ApplicationMailer

  def status_notification_article(article)
    @article = article
    @user = User.find(article.user)
    mail(to: @user.email, subject: 'Article status')
  end

end
