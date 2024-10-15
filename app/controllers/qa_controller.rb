class QaController < ApplicationController
    before_action :authenticate_user!
    before_action :check_qa_role
  
    def index
      @projects = Project.all
    end
  
    def report_bug
      @bug = Bug.new
    end
  
    def create_bug
      @bug = current_user.reported_bugs.build(bug_params)
      if @bug.save
        redirect_to bugs_path, notice: 'Bug reported successfully.'
      else
        render :report_bug
      end
    end
  
    def show_projects
      @projects = Project.all
    end
  
    private
  
    def bug_params
      params.require(:bug).permit(:title, :deadline, :bug_type, :status, :project_id)
    end
  
    def check_qa_role
      redirect_to root_path unless current_user.qa?
    end
  end
  