class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type: { developer: 'developer', manager: 'manager', qa: 'qa' }



  has_many :managed_projects, through: :manager, class_name: 'Project'

  has_many :created_bugs, class_name: 'Bug', foreign_key: 'creator_id'
  has_many :assigned_bugs, class_name: 'Bug', foreign_key: 'developer_id'

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :user_type, presence: true, inclusion: { in: ['developer', 'manager', 'qa'] }

  def developer?
    user_type == 'developer'
  end
  def manager?
    user_type == 'manager'
  end
  def qa?
    user_type == 'qa'
  end
end


