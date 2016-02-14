class Category < ActiveRecord::Base

  has_and_belongs_to_many :articles
  has_and_belongs_to_many :subscribers, class_name: 'User'

  #subscribe or unsubscribe category
  def self.sub_unsub_category(category, user)
    if user.categories.include?(category)
      user.categories.destroy(category)
    else
      user.categories << category
    end
  end
  #return two relation object: categories of article that user no subs. and subs.
  def self.user_categories(article, user)
    [article.categories - user.categories, article.categories & user.categories ]
  end

end
