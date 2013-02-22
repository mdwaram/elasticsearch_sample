class ArticlesController < ApplicationController
  def index
    @articles = Article.search(params)
  end

  def search
    redirect_to articles_path and return unless params[:query].present?
    @articles = Article.search(params[:query])
  end
  
  def show
    @article = Article.find(params[:id])
    @comment = Comment.new(article_id: @article.id)
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes params[:article]
      flash[:success] = 'Article successfully updated'
      redirect_to articles_path
    else
      render :edit
    end
  end
end
