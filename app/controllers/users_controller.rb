class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :check_user, only: %i[edit update]

  def index
    @users = User.all
  end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_user
    redirect_to task_path unless params[:id] == current_user.id
  end
end
