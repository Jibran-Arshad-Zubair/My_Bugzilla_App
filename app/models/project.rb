# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :bugs
  has_many :projects_users
  has_many :users, through: :projects_users

  validates :name, presence: true
  validates :description, presence: true
end
