class ArticlesController < ApplicationController
  before_action :set_article, only:[:show, :edit, :update, :destroy, :favorite]
  before_action :set_articles_new, only:[:index, :edit, :show, :new, :favorite, :favorite, :favorites]
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :favorite]

  def index
    @articles = Article.all.order('id DESC')
  end

  def show
    @comments = Comment.where(:article_id => @article.id)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    url_id = @article.movie.gsub('https://www.youtube.com/watch?v=','')
    url_emb = "https://www.youtube.com/embed/"
    @article.movie  = url_emb + url_id

    if @article.save
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @article.update(article_params)
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @favorite = FavoriteArticle.where(:article_id => "params[:id]")
    @favorite.each do |f|
      f.delete
    end
    @article.delete
    redirect_to articles_path
  end

  def favorite
    @favorite = FavoriteArticle.new
    @favorite.user_id = current_user.id
    @favorite.article_id = @article.id
    if @favorite.save
      redirect_to articles_path
    else
      redirect_to article_path(@article.id)
    end
  end

  def favorites
    @user = current_user.id
    @favorites = FavoriteArticle.where(:user_id => @user)
  end

  def favorite_destroy
    @favorite = FavoriteArticle.where(:article_id => params[:id])
    @favorite.each do |a|
      a.delete
    end
    redirect_to favorites_articles_path
  end

  private

  def article_params
    params[:article].permit(:title, :content, :user_id, :movie)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def set_articles_new
    @articles_new = Article.order('id DESC')
  end

end