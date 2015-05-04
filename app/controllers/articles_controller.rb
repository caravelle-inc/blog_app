class ArticlesController < ApplicationController
  before_action :set_article, only:[:show, :edit, :update, :destroy, :favorite, :article_search]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = Article.all.order('created_at DESC').page(params[:page])
  end

  def show
    @comment = Comment.new
    @article_comments = Comment.where(:article_id => @article.id)
    @article_user = @article.user
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
        flash[:notice] = "記事を作成しました。"
        redirect_to articles_path
      else
        flash[:notice] = "記事を作成出来ませんでした。"
        render 'new'
      end

    else
      @article.youtube_url = ""

      if @article.save
        flash[:notice] = "記事を作成しました。"
        redirect_to articles_path
      else
        flash[:alert] = "記事を作成出来ませんでした。"
        render 'new'
      end
    end

  end

  def edit

  end

  def update
    if @article.update(article_params)
      flash[:notice] = "記事を編集しました。。"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:alert] = "記事を削除しました。"
    redirect_to(:back)
  end

  def favorite
    @favorite_article = FavoriteArticle.new
    @favorite_article.user_id = current_user.id
    @favorite_article.article_id = @article.id
    @favorite_article.save
    flash[:notice] = "お気に入りに追加しました。"
    redirect_to(:back)
  end

  def favorite_list
    @favorite_list = FavoriteArticle.where(:user_id => current_user.id)
  end

  def my_favorites
    @user = User.find(params[:format])
    @my_favorites = FavoriteArticle.where(:user_id => @user.id)
  end

  def destroy_favorite
    @favorite = FavoriteArticle.find_by(article_id: params[:id], user_id: current_user.id)
    @favorite.destroy
    flash[:alert] = "お気に入りを削除しました。"
    redirect_to(:back)
  end


  def my_articles
    @user = User.find(params[:format])
    @user_articles = @user.articles.order('created_at DESC')
  end

  private

  def article_params
    params[:article].permit(:title, :content, :user_id, :youtube_url)
  end

  def set_article
    @article = Article.find(params[:id])
  end


end