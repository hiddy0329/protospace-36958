class CommentsController < ApplicationController
  def create
    #commentを保存できるかできないかで行き先を分岐
    @comment = Comment.new(comment_params) #新しいレコードに保存したいデータを引数として渡す
    if @comment.save #もし保存できたなら
      redirect_to prototype_path(@comment.prototype) #詳細画面へ遷移
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show" #保存できなかったらshowページをそのまま呼び出す
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
