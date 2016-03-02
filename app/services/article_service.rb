# it used instead callbacks
class ArticleService
  def self.update(article, params)
    # save article with new attributes
    article.assign_attributes(params)
    article.save!

    # # NOTE: FOR HEROKU MAIL SENDING IS DISABLED
    # # send mail to article's author
    # UserMailer.status_article_notification(article.id).deliver_later unless article.approved.nil?
    # # send mails to subscribers of article's categories
    # if article.approved?
    #   article.list_of_subscribers.each do |user_id|
    #       UserMailer.subscribers_notification(article.id, user_id).deliver_later
    #   end
    # end
  end
end