# :nodoc:
class Article < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :categories

  acts_as_commentable
  acts_as_taggable

  validates :user, :header, :announce, :body, presence: true
  # FIXME: NEED CREATE SERVICE LAYER FOR NOTIFICATION
  # after_update :subscribers_notification

  # FIXME: (LOGIC AND PLACE)
  # Assign to Article categories that user checked
  def assign_categories(categories)
    categories.each do |key, _value|
      if category = Category.find_by_name(key)
        self.categories << category
      end
    end
  end

  # it takes all subscribers of article categories
  def list_of_subscribers
    list = []
    self.categories.each do |category|
      category.subscribers.each do |user|
        list << user.id
      end
    end
    list.uniq!
    list - [self.user_id]
  end
end
