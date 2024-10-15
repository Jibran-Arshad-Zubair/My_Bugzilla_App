class Bug < ApplicationRecord
  validates :title, uniqueness: { scope: :project_id, message: "Title should be unique within the project" }
  validates :status, presence: true, inclusion: { in: ['new', 'started', 'completed', 'resolved'] }
  validates :bug_type, presence: true, inclusion: { in: ['feature', 'bug'] }
  validates :project_id, presence: true
  validates :creator_id, presence: true
  validates :description, presence: false 
  validates :deadline, presence: true

  enum bug_type: {
    feature: 'feature',
    bug: 'bug'
  }
  STATUS_OPTIONS = ['new', 'started', 'completed']

  def self.status_options
    STATUS_OPTIONS
  end
  
  private

def validate_status_based_on_type
    valid_statuses = if type == 'feature'
                       ['new', 'started', 'completed']
                     else
                       ['new', 'started', 'resolved']
                     end

    unless valid_statuses.include?(status)
      errors.add(:status, "is not valid for the selected type '#{type}'")
    end
  end
end
