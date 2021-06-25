class Api::V1::TasksController < ApiController
  def index
    tasks = Task.all
    render json: { status: 'SUCCESS', message: 'Loaded posts', data: tasks }
  end

  # POST
  def create
    task = Task.new(task_params)

    if task.save
      render json: { status: 'SUCCESS', message: 'created new task', data: task }
    else
      render json: { status: 'Failed', message: 'Happend any error'}
    end
  end

  def destroy
    task = Task.find(params[:id])
      task.destroy
      render json: { status: 'SUCCESS', message: 'Deleted the task', data: task }
    rescue ActiveRecord::RecordNotFound
      render json: { status: 'Failed', message: 'Delete failed. Task not found', data: { id: params[:id] } }
  end

  private

  def task_params
    params.require(:task).permit(:title)
  end
end
