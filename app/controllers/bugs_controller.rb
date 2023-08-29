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

    def assign_to_myself
      @bug = Bug.find(params[:id])
      
      if current_user.developer? && @bug.project.users.include?(current_user)
        @bug.update(developer: current_user, status: 'started')
        redirect_to @bug, notice: 'Bug assigned to yourself.'
      else
        redirect_to @bug, alert: 'You cannot assign this bug to yourself.'
      end
    end

    def pick_up
      @bug = Bug.find(params[:id])
      
      if current_user.developer? && @bug.project.users.include?(current_user) && @bug.developer.nil?
        @bug.update(developer: current_user, status: 'started')
        redirect_to @bug, notice: 'Bug picked up.'
      else
        redirect_to @bug, alert: 'You cannot pick up this bug.'
      end
    end

    def mark_resolved
      @bug = Bug.find(params[:id])
      
      if current_user.developer? && @bug.developer == current_user
        @bug.update(status: 'resolved')
        redirect_to @bug, notice: 'Bug marked as resolved.'
      else
        redirect_to @bug, alert: 'You cannot mark this bug as resolved.'
      end
    end
  
    private
  
    def bug_params
      params.require(:bug).permit(:title, :deadline, :screenshot, :type, :status, :creator_id, :developer_id, :project_id)
    end

    def authorize_delete_bug
      return if current_user.manager? # Allow managers to delete bugs
      @bug = Bug.find(params[:id])
      return if @bug.developer == current_user # Allow developers to delete bugs they are assigned to
      redirect_to @bug, alert: 'You are not authorized to delete this bug.'
    end

    # app/controllers/bugs_controller.rb
def bug_params_create
  params.require(:bug).permit(:title, :deadline, :bug_type, :status)
end

end
  