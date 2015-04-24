class CommentsController < ApplicationController

  before_action :set_comment, only: [:show, :edit, :update, :destroy]
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
    # @article = Article.find(params[:article_id])
    @comment = Comment.new(comment_params)
    @comment.article_id = params[:article_id]
    @comment.user_id = current_user.id

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
    @comment.delete
    redirect_to article_path(@article.id)
  end


  private

  def comment_params
    params[:comment].permit(:comment)
  end

  def set_comment
    @article = Artcle.find(params[:article_id])
    @comment = Comment.find(params[:id])
  end


end
