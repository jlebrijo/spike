class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update toggle_done destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all.order :created_at
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: "Task was successfully created." }
        format.turbo_stream
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('new_task',
             partial: 'form', locals: { task: @task })
        end
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url, notice: "Task was successfully updated." }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@task)}
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH /tasks/1/toggle_done or /tasks/1/toggle_done.json
  def toggle_done
    @task.toggle! :done
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully updated." }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@task)}
      format.json { render :show, status: :ok, location: @task }
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@task)}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:done, :title)
    end
end
