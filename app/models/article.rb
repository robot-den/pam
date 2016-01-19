class Article < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :categories

  validates :user, :header, :announce, :body, presence: true
  
  #FIXME(logic and place)
  #Assign to Article categories that user checked
  def assign_categories(categories)
    categories.each do |key, value|
      if category = Category.find_by_name(key)
        self.categories << category
      end
    end
  end
  
end
