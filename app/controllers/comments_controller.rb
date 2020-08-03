class CommentsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new(comment_params)
    @comment.recipe_id = @recipe.id
    @comment.user_id = current_user.id
    @comment.score = Language.get_data(comment_params[:comment])
    @comments = @recipe.comments.order(created_at: :desc)
    if @comment.save
      @comment.recipe.create_notification_comment!(current_user, @comment.id)
      flash[:notice] = "コメントを投稿しました"
      render :index
    else
      flash[:comment_alert] = "空白、100文字以上、ネガティブ表現の含まれるコメントは投稿できません"
      render :index
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.find_by(id: params[:id], recipe_id: @recipe.id)
    @comments = @recipe.comments.order(created_at: :desc)
    if @comment.user_id != current_user.id
      flash[:alert] = "不正なアクセスです"
      redirect_to root_path
    end
    @comment.destroy
    render :index
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
