class TodosController < ApplicationController
  def index
    if params[:search]
      todos = Todo.where('title LIKE ?', "%#{params[:search]}%")
    else
      todos = Todo.order("created_at DESC")
    end
    render json: todos
  end

  def create
    todo = Todo.create(todo_param)
    render json: todo
  end

  def update
    todo = Todo.find(params[:id])
    todo.update(todo_param)
    render json: todo
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy
    head :no_content, status: :ok
  end
  
  private
    def todo_param
      params.require(:todo).permit(:title, :done)
    end
end
