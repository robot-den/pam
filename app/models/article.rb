class Article < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :categories

  acts_as_commentable
  acts_as_taggable

  validates :user, :header, :announce, :body, presence: true
  #FIXME Need create service layer for notification
  # after_update :status_notification
  # after_update :subscribers_notification
  
  #FIXME(logic and place)
  #Assign to Article categories that user checked
  def assign_categories(categories)
    categories.each do |key, value|
      if category = Category.find_by_name(key)
        self.categories << category
      end
    end
  end

  private

  def subscribers_notification
    if self.approved?
      self.categories.each do |category|
        category.subscribers.each do |user|
          UserMailer.subscribers_notification(self, user).deliver_later
        end
      end
    end
  end

  def status_notification
    UserMailer.status_article_notification(self).deliver_later unless self.approved.nil?
  end

end
