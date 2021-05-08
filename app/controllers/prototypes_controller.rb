class PrototypesController < ApplicationController
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
   @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototyp_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototyp_params)
      redirect_to prototype_path
    else
      render  edit_prototype_path
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.destroy
      redirect_to root_path
    end
  end

  private
  def prototyp_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def contributor_confirmation
    @prototype = Prototype.find(params[:id])
    redirect_to root_path unless current_user == @prototype.user
  end
end