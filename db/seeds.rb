#create users
name = %w(dmitry evgeny zoya oleg diman nikita fedor innokentiy varvara semen)
10.times do |i|
  User.create(name: name[i], email: "#{name[i]}@example.com", password: "12345678", password_confirmation: "12345678")
end
#create user with admin privilege
User.create(name: "admin", email: "admin@example.com", password: "12345678", password_confirmation: "12345678", admin: true)
#create categories for article
categories = %w(sport culture policy technologies games)
categories.each do |category|
  Category.create(name: category, description: "About #{category}")
end
#create articles
15.times do |i|
  article = Article.create(header: "Article №#{i+1}", announce: "This article created without redactor", body: "Just text article. You need create article with redactor", user_id: rand(1..9), approved: true)
  article_categories = categories.sample(rand(1..3))
  article_categories.each do |category|
    article.categories << Category.find_by_name(category)
  end
end
# #create registered users comments for articles
# 30.times do |i|
#   article = Article.find(rand(1..15))
#   comment = Comment.create(article_id: article.id, owner_name: name.sample, body: "I like it ! I read this article #{i+1} times!!")
#   article.comments << comment  
# end
# #create unregistered users comments for random comments
# 30.times do |i|
#   batya_comment = Comment.find(rand(1..Comment.count))
#   new_comment = Comment.create(article_id: batya_comment.article_id, owner_name: "#{i+1} (unregistered)", body: "Nice article! I'll be back here #{i+1} times!")
#   batya_comment.comments << new_comment  
# end