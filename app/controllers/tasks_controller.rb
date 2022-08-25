class TasksController < ApplicationController
  before_action :set_team
  before_action :set_project
  before_action :isMember
  before_action :correct_user, only: [:create, :update, :destroy]
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    @tasks = @project.tasks
    
    render json: @tasks
  end

  def show
    render json: @task
  end

  def create
    @task = Task.new(task_params)
    @task.project_id = @project.id
    if @task.save
      render json: @task, status: :created,
        location: team_project_task_url(@team, @project, @task)
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

  private
    def set_project
      @project = Project.find(params[:project_id])
      raise 'error' if !@project
    end

    def set_team
      @team = Team.find(params[:team_id])
      raise 'error' if !@team
    end
    
    def set_task
      @task = @project.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :completed, :duedate, :completed_at)
    end

    def correct_user
      begin
        if @team.id == @project.team_id and @team.user_id == current_user.id\
          || @team.id == @project.team_id and isMember
          return true
        else
          head :forbidden
          return false
        end
      end
      head :forbidden
      false
    end
end
