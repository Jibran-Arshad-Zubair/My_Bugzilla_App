class Project < ApplicationRecord
  has_many :bugs
  has_many :projects_users
  has_many :users, through: :projects_users
  # belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'

  validates :name, presence: true
  validates :description, presence: true
 
end
