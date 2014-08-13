class TasksController < ApplicationController

  def new
    if session[:user_id] == nil
      redirect_to '/signin'
    else
      @task_list_id = params[:id]
      @task = Task.new
      @users = []
      User.where.not(id: session[:user_id]).each do |user|
        @users << "Me"
        @users << user.name
      end
      @users
    end
  end

  def create
    @date = params[:datepicker].to_date
    if @date != nil && @date >= Date.today
      @task = Task.new(task: params[:task][:task],
                       date: params[:datepicker],
                       task_list_id: params[:task][:task_list_id],
                       assigned_to: params[:task][:assigned_to])
      if @task.save
        flash[:notice] = "Task was created successfully!"
        redirect_to '/'
      else
        flash[:notice] = "Your task could not be created"
        redirect_to :back
      end
    else
      render :new
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to(:back)
  end

  def complete
    @task = Task.find(params[:id])
    @task.complete = true
    @task.save
    redirect_to :back
  end

  def search
    @search_term = params[:search]
    @search_results = Task.where("task like ?", "%#{params[:search]}%")
  end

end