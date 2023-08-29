class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type: { developer: 'developer', manager: 'manager', qa: 'qa' }

  has_many :managed_projects, class_name: 'Project', foreign_key: 'manager_id'
  has_many :created_bugs, class_name: 'Bug', foreign_key: 'creator_id'
  has_many :assigned_bugs, class_name: 'Bug', foreign_key: 'developer_id'

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :user_type, presence: true, inclusion: { in: ['developer', 'manager', 'qa'] }

end
