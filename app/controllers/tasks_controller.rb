class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy, :start_timer, :stop_timer]

  def index
    @tasks = Task.all
    render json: @tasks
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
  end

  def start_timer
    @task.update(started_at: Time.now) unless @task.started_at
    render json: @task
  end

  def stop_timer
    if @task.started_at
      elapsed_time = (Time.now - @task.started_at).to_i
      @task.update(time_spent: @task.time_spent.to_i + elapsed_time, started_at: nil)
    end
    render json: @task
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :completed, :time_spent, :started_at)
  end
end
