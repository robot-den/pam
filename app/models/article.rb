class Article < ActiveRecord::Base

  belongs_to :user

  validates :user, :header, :announce, :body, presence: true
  
end
