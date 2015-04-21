class ArticlesController < ApplicationController
  before_action :set_article, only:[:show, :edit, :update, :destroy, :favorite, :article_search]
  before_action :set_articles_new
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :favorite]

  def index
    # @articles = Article.all.order('id DESC')
    @articles = Article.all.order('id DESC').page(params[:page])
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

    if @article.movie.include?('https://www.youtube.com/')
      url_id = @article.movie.gsub('https://www.youtube.com/watch?v=', '')
      base_url = "https://www.youtube.com/embed/"
      @article.movie = base_url + url_id

      if @article.save
        redirect_to articles_path
      else
        render 'new'
      end

    else
      @article.movie = ""

      if @article.save
        redirect_to articles_path
      else
        render 'new'
      end
      # @article.save ? redirect_to articles_path : render 'new'

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
    # @favorite = FavoriteArticle.find_by(article_id: params[:id])
    # @favorite.delete if @favorite.present?
    @article.favorite_articles.delete
    @article.delete
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
    # @user = current_user.id
    @favorites = FavoriteArticle.where(:user_id => current_user.id)
  end

  def favorite_destroy
    @favorite = FavoriteArticle.find_by(article_id: params[:id], user_id: current_user.id)
    @favorite.delete
    redirect_to favorites_articles_path
  end

  def article_search
    config = YAML.load_file( 'config.yml' )
    gracenote_conf = config["gracenote"]
    spec = {:clientID => gracenote_conf["clientID"], :clientTag => gracenote_conf["clientTag"],
            :userID => gracenote_conf["userID"]}
    gracenote = Gracenote.new(spec)
    # begin
    @result = gracenote.findTrack(params[:artist], params[:album_title], params[:track_title], "0")
    p @result
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where(:article_id => @article.id)

    render 'show'
  end

  private

  def article_params
    params[:article].permit(:title, :content, :user_id, :movie)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def set_articles_new
    @articles_new = Article.order('id DESC').limit(10)
  end

end