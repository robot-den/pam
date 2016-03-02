# :nodoc:
class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles
  has_and_belongs_to_many :subscribers, class_name: 'User'

  validates :name, presence: true

  # subscribe or unsubscribe category
  def self.sub_unsub_category(category, user)
    if user.categories.include?(category)
      user.categories.destroy(category)
    else
      user.categories << category
    end
  end
end
