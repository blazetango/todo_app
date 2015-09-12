class TodosController < ApplicationController
	before_action :set_task, only: [:create, :mark_complete, :mark_incomplete, :destroy]
  def index
    set_user_task_scope
  end
  
  def new
  	@task = Task.new
  end

  def create
  	@task = current_user.tasks.create(task_params)
  	set_user_task_scope
  end

  def mark_complete
    @task.mark_complete
    set_user_task_scope 
  end

  def mark_incomplete
    @task.mark_incomplete
    set_user_task_scope
  end

  def destroy
    @task.destroy
    redirect_to action: 'index'
  end

  private
  	def task_params
  		params.require(:task).permit(:name, :completed, :user_id)
  	end

    def set_task
      @task = Task.find(params[:id])
    end

  	def set_user_task_scope
  		@completed_tasks 		= Task.completed(current_user) 
  		@incompleted_tasks 	= Task.not_completed(current_user)
  	end
end
