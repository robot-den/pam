class Category < ActiveRecord::Base

  has_and_belongs_to_many :articles
  has_and_belongs_to_many :subscribers, class_name: 'User'

end
