class CommentsController < ApplicationController
  before_action :set_comment, except: [:create]
  before_action :set_article, only: [:edit, :update]
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = "コメントしました。"
      redirect_to article_path(params[:article_id])
    else
      flash[:alert] = "コメント出来ませんでした。"
      render 'new'
    end
  end

  def edit
    if @comment.user_id != current_user.id
      flash[:alert] = "他のユーザのコメントは編集できません。"
      redirect_to(:back)
    end
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "コメントを編集しました。"
      redirect_to article_path(@article.id)
    else
      flash[:alert] = "コメントを編集できませんでした。"
      render 'edit'
    end
  end

  def destroy
    if @comment.user_id != current_user.id
      flash[:alert] = "他のユーザのコメントは削除できません。"
      redirect_to(:back)
    end
    @comment.destroy
    flash[:alert] = "コメントを削除しました。"
    redirect_to article_path(@comment.article_id)
  end


  private

  def comment_params
    params[:comment].permit(:comment, :article_id, :user_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

end
