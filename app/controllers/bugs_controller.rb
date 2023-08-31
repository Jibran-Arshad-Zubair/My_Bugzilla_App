# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :authorize_delete_bug, only: [:destroy]

  def index
    @bugs = Bug.all
  end

  def new
    @bug = Bug.new
  end

  def create
    @bug = Bug.new(bug_params_create)
    if @bug.save
      redirect_to bugs_path, notice: 'Bug was successfully created.'
    else
      render :new
    end
  end

  def show
    @bug = Bug.find(params[:id])
  end

  def assign_bug
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.find(params[:id])
    @bug.update(developer: current_user)
    redirect_to project_path(@project), notice: 'Bug assigned to you!'
  end

  def pick_up
    @bug = Bug.find(params[:id])
    if current_user.developer? && @bug.project.users.include?(current_user) && @bug.developer.nil?
      @bug.update(developer: current_user)
      redirect_to bugs_path, notice: 'Picked up the bug successfully.'
    else
      redirect_to bugs_path, alert: 'Unable to pick up the bug.'
    end
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :deadline, :type, :status, :creator_id, :developer_id, :project_id)
  end

  def authorize_delete_bug
    return if current_user.manager?

    @bug = Bug.find(params[:id])
    return if @bug.developer == current_user

    redirect_to @bug, alert: 'You are not authorized to delete this bug.'
  end

  def bug_params_create
    params.require(:bug).permit(:title, :deadline, :bug_type, :status)
  end
end
