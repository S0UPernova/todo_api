class TasksController < ApplicationController
  before_action :get_team
  before_action :get_project
  before_action :correct_user
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    @tasks = @project.tasks
    
    render json: @tasks
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.project_id = @project.id
    if @task.save
      render json: @task, status: :created, location: team_project_task_url(@team, @project, @task)
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  private
    def get_project
      @project = Project.find(params[:project_id])
      raise 'error' if !@project
    end

    def get_team
      @team = Team.find(params[:team_id])
      raise 'error' if !@team
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      # @task = Task.find(params[:id])
      @task = @project.tasks.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :description, :completed, :duedate, :completed_at)
    end

    def correct_user
      begin
        if @team.id == @project.team_id and @team.user_id == current_user.id
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
