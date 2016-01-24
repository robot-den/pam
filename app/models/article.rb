class Article < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :comments, as: :commentable, dependent: :destroy

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

  def take_sort_comments(article)
    a = []
    if b = Comment.where("article_id = #{article.id}") then
      a = b.select { |x| x.commentable_type == 'Article' }
      b = b.to_a.reject! { |x| x.commentable_type == 'Article' }
    end
    while b.empty? == false
      a.each_with_index do |elem, i|
        d = b.select { |z| z.commentable_id == elem.id }
        if d != []
            a = a.insert(i+1, d).flatten
            b.reject! { |z| z.commentable_id == elem.id }
            break
        end
      end
    end
    a
  end

  
end
