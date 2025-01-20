class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: I18n.t('flash.tasks.create.notice')
    else
      flash.now[:alert] = I18n.t('flash.tasks.create.alert', errors: @task.errors.full_messages.join(", "))
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: I18n.t('flash.tasks.update.notice')
    else
      flash.now[:alert] = I18n.t('flash.tasks.update.alert', errors: @task.errors.full_messages.join(", "))
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: I18n.t('flash.tasks.destroy.notice')
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed)
  end

end
