class ArticlesController < ApplicationController
  before_action :set_article, only:[:show, :edit, :update, :destroy, :favorite, :article_search]
  # before_action :set_user, only:[:show, :edit, :update, :destroy, :favorite, :article_search]

  def index
    @articles = Article.all.order('created_at DESC').page(params[:page])
  end

  def show
    @comment = Comment.new
    @comments = Comment.where(:article_id => @article.id)
    @result = []
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    if @article.youtube_url.include?('https://www.youtube.com/')
      url_id = @article.youtube_url.gsub('https://www.youtube.com/watch?v=', '')
      base_url = "https://www.youtube.com/embed/"
      @article.youtube_url = base_url + url_id

      if @article.save
        redirect_to articles_path
      else
        render 'new'
      end

    else
      @article.youtube_url = ""

      if @article.save
        redirect_to articles_path
      else
        render 'new'
      end
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
    @article.destroy
    if admin_signed_in?
      redirect_to admins_path
    else
      redirect_to user_path(current_user)
    end

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
    @user_id = User.find(params[:format])
    @favorites = FavoriteArticle.where(:user_id => @user_id)
  end

  def favorite_destroy
    @favorite = FavoriteArticle.find_by(article_id: params[:id], user_id: current_user.id)
    @favorite.delete
    redirect_to favorites_articles_path
  end


  def my_articles
    @user = User.find(params[:format])
    @user_articles = @user.articles
  end

  private

  def article_params
    params[:article].permit(:title, :content, :user_id, :youtube_url)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  # def set_user
  #   @user = User.find(params[:format])
  # end


end