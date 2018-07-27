class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :check_user, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :get_users, only: %i[new edit]

  def index
    @tasks = Task.where(owner_id: current_user.id).or(Task.where(assigned_id: current_user.id))
  end

  def show; end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    params[:task][:owner_id] = current_user.id
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_users
    @users = [['no one', nil]]
    @users.concat(User.all.collect { |p| ["#{p.first_name} #{p.last_name}", p.id] })
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def check_user
    redirect_to '/tasks' unless @task.owner == current_user || @task.assigned == current_user
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :owner_id, :assigned_id)
  end
end
