class CommentsController < ApplicationController

  before_action :set_comment, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]


  def index
    @comment = Comment.all
  end

  def show
  end

  def new
    @article = Article.find(params[:article_id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to article_path(params[:article_id])
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to article_path(@article.id)
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to article_path(@comment.article_id)
  end


  private

  def comment_params
    params[:comment].permit(:comment, :article_id, :user_id)
  end

  def set_comment
    @article = Artcle.find(params[:article_id])
    @comment = Comment.find(params[:id])
  end


end
