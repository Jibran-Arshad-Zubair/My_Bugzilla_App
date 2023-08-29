class Project < ApplicationRecord
  # belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'
  has_many :bugs
  has_many :projects_users
  has_many :users, through: :projects_users

  validates :name, presence: true
  validates :description, presence: true
  # validates :manager_id, presence: true
end
