# frozen_string_literal: true

class ProjectsUser < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :user_id, presence: true
  validates :project_id, presence: true
end
