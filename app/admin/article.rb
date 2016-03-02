ActiveAdmin.register Article do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :header, :announce, :body, :approved, :user_id
  #
  controller do
    # This code is evaluated within the controller class

    def update
      article = Article.find(params[:id])
      ArticleService.update(article, article_params)
      redirect_to admin_articles_url
    end

    def article_params
      params.require(:article).permit!
    end
  end
end
