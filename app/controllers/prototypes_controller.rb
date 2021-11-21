class PrototypesController < ApplicationController
  before_action  :authenticate_user!, only: [:new, :edit, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless @prototype.user_id == current_user.id 
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit
    end
  end

  def new
    @prototype = Prototype.new
  end

  def create
    #prototypeを保存できるかできないかで行き先を分岐
    @prototype = Prototype.new(prototype_params) #新しいレコードに保存したいデータを引数として渡す
    if @prototype.save #もし保存できたなら
      redirect_to root_path #トップ画面へ遷移
    else
      render :new #保存できなかったらコントローラーのnewアクションから再度新規投稿画面の表示をする(ちなみに改めてルーティングを行ってはいない)
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end
