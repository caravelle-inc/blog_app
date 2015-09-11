class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
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

    youtube_url = 'https://www.youtube.com/'

    if @article.youtube_url.include?(youtube_url)
      url_id = @article.youtube_url.gsub(youtube_url + 'watch?v=', '')
      base_url = youtube_url + 'embed/'
      @article.youtube_url = base_url + url_id

      if @article.save
        created_article
      else
        not_created_article
      end

    else
      @article.youtube_url = ""

      if @article.save
        created_article
      else
        not_created_article
      end
    end
  end

  def edit
    if @article.article_owner?(current_user)
    else
      flash[:alert] = "他のユーザの記事は編集できません。"
      redirect_to user_path(@article.user_id)
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "記事を編集しました。"
      redirect_to articles_path
    else
      flash[:alert] = "記事を編集できませんでした。"
      render 'edit'
    end
  end

  def destroy
    if @article.article_owner?(current_user)
      @article.destroy
      flash[:alert] = "記事を削除しました。"
      redirect_to(:back)
    else
      flash[:alert] = "他のユーザの記事は削除できません。"
      redirect_to new_admin_session_path
    end
  end

  private

  def article_params
    params[:article].permit(:title, :content, :user_id, :youtube_url)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def created_article
    flash[:notice] = "記事を作成しました。"
    redirect_to articles_path
  end

  def not_created_article
    flash[:alert] = "記事を作成出来ませんでした。"
    render 'new'
  end

end
