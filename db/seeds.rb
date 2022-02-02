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

Team.find_by(name: 'firstTeam').projects.create(name: 'projectName', description: "project description",
                                                requirements: "list of requirements, should be a json string")

Team.find_by(name: 'secondTeam').projects.create(name: 'projectName', description: "project description",
                                                requirements: "list of requirements, should be a json string")
