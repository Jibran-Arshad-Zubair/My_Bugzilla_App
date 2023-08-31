class ProjectsController < ApplicationController
  before_action :authenticate_user! 
  def index
    @projects = Project.all
   
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new if current_user.manager?
  end

  def create
    @project = Project.new(project_params) if current_user.manager?
    
    if @project.save
      redirect_to projects_path, notice: t('flash.project.created')
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    
    if @project.update(project_params)
      redirect_to projects_path, notice: t('flash.project.updated')
    else
      render :edit
    end
  end

  def add_developer
    @project = Project.find(params[:id])
    render 'add_developer'
  end

  def add_qa
    @project = Project.find(params[:id])
    render 'add_qa'
  end

  
  
  def delete_developers
    project = Project.find(params[:id])
    developer_ids = params[:developer_ids]

    if developer_ids.present?
      developers = User.where(id: developer_ids)
      project.users.delete(developers)
      flash[:notice] = "Selected developers have been removed from the project."
    else
      flash[:alert] = "No developers were selected."
    end

    redirect_to project_path(project)
  end






  def delete
    @projects = Project.find(params[:id])
    @projects.destroy
    redirect_to projects_path, notice: t('flash.project.deleted')
  end
  
  private

  def project_params
    params.require(:project).permit(:name, :description )
  end
end
