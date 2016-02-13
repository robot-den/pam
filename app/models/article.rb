class Article < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :categories

  acts_as_commentable

  validates :user, :header, :announce, :body, presence: true

  after_update :status_notification
  
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

  def status_notification
    UserMailer.status_notification_article(self).deliver_later unless self.approved.nil?
  end

end
