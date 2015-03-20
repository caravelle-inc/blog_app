class ArticlesController < ApplicationController
    before_action :set_article, only:[:show, :edit, :update, :destroy, :favorite]
    before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy, :favorite]

    def index
      @articles = Article.all
    end

    def show
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new(article_params)
      @article.user_id = current_user.id
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
      @favorites = FavoriteArticle.all
    end


    private

    def article_params
      params[:article].permit(:title, :content, :user_id)
    end

    def set_article
      @article = Article.find(params[:id])
    end

  end

