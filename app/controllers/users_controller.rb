class UsersController < ApplicationController

def show
  @user = User.find(params[:id])
  @prototype = Prototype.find_by(user_id: params[:id])
end

end
