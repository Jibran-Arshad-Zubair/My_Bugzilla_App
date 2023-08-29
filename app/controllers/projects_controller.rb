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

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: t('flash.project.deleted')
  end
  
  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
