# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: 'firstUser',
  handle: "the first",
  email: "user@example.com",
  password: 'foobar',
  password_confirmation: "foobar")
  
User.create!(name: 'secondUser',
  handle: "the second",
  email: "example@example.com",
  password: 'foobar',
  password_confirmation: "foobar")

User.first.teams.create!(name: 'firstTeam', description: "firstTeam description")

User.second.teams.create(name: 'secondTeam', description: "secondTeam description")

Team.find_by(name: 'firstTeam').projects.create(name: 'firstProjectName', description: "project description",
                                                requirements: "list of requirements, should be a json string")

Team.find_by(name: 'secondTeam').projects.create(name: 'secondProjectName', description: "project description",
                                                requirements: "list of requirements, should be a json string")

Team.find_by(name: 'firstTeam').projects.create(name: 'thirdProjectName', description: "project description",
                                                requirements: "list of requirements, should be a json string")

Project.find_by(name: 'firstProjectName').tasks.create(name: 'taskName', description: "task description")
Project.find_by(name: 'firstProjectName').tasks.create(name: 'secondTaskName', description: "second task description")
Project.find_by(name: 'secondProjectName').tasks.create(name: 'thirdTaskName', description: "Third task description")
Project.find_by(name: 'thirdProjectName').tasks.create(name: 'fourthTaskName', description: "second task description")
