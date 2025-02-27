# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).


# db/seeds.rb

# Create user roles p

user_types = user_types.create([
  { name: 'manager' },
  { name: 'developer' },
  { name: 'qa' }
])
  
  # Create users
  manager = User.create(username: 'John Manager', email: 'john@example.com', password: 'password', user_type: 'manager')
  developer1 = User.create(username: 'Alice Developer', email: 'alice@example.com', password: 'password', user_type: 'developer')
  developer2 = User.create(username: 'Bob Developer', email: 'bob@example.com', password: 'password', user_type: 'developer')
  qa1 = User.create(username: 'Eve QA', email: 'eve@example.com', password: 'password', user_type: 'qa')
  
# Create projects
project1 = Project.create(name: 'Bug Tracking App')
project2 = Project.create(name: 'Feature Development')

# Add developers and QAs to projects
project1.users << developer1
project1.users << developer2
project2.users << developer1
project2.users << qa1
# Create bugs
bug1 = Bug.create(title: 'Login Bug',deadline: 1.week.from_now, project_id: project1.id, creator_id: developer1.id, developer_id: developer2.id, bug_type: 'bug', status: 'new')
bug2 = Bug.create(title: 'Feature Request', deadline: 2.weeks.from_now, project_id: project2.id, creator_id: developer2.id, developer_id: developer1.id, bug_type: 'feature', status: 'new')
bug3 = Bug.create(title: 'UI Bug',  deadline: 1.week.from_now, project_id: project1.id, creator_id: developer2.id, developer_id: developer1.id, bug_type: 'bug', status: 'new')


# <% if current_user&.manager? %>
#   <div class="form-group">
#     <%= f.label :user_type %>
#     <%= f.select :user_type, options_for_select(User.user_types.keys - ["developer", "qa"]), class: "form-control" %>
#   </div>
# <% elsif !user_signed_in? %>
#   <div class="form-group">
#     <%= f.label :user_type %>
#     <%= f.select :user_type, options_for_select(User.user_types.keys - ["manager"]), class: "form-control" %>
#   </div>
# <% end %>