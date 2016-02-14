class UserMailer < ApplicationMailer

  def status_article_notification(article)
    @article = article
    @user = User.find(article.user_id)
    mail(to: @user.email, subject: 'Article status')
  end

  def subscribers_notification(article, user)
    @article = article
    @user = user
    mail(to: @user.email, subject: 'New Article!')
  end

end
