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

Team.create(
  user_id: User.first.id,
  name: 'firstTeam',
  description: "firstTeam description")

Team.create(
  user_id: User.second.id,
  name: 'secondTeam',
  description: "secondTeam description")
  
Project.create(
  team_id: Team.first.id,
  name: 'firstProjectName',
  description: "project description",
  requirements: "list of requirements, should be a json string")

Project.create(
  team_id: Team.first.id,
  name: 'secondProjectName',
  description: "project description",
  requirements: "list of requirements, should be a json string")

Project.create(
  team_id: Team.second.id,
  name: 'thirdProjectName',
  description: "project description",
  requirements: "list of requirements, should be a json string")

Task.create(
  project_id: Project.first.id,
  name: 'taskName',
  description: "task description")

Task.create(
  project_id: Project.first.id,
  name: 'secondTaskName',
  description: "second task description")

Task.create(
  project_id: Project.second.id,
  name: 'thirdTaskName',
  description: "Third task description")

Task.create(
  project_id: Project.third.id,
  name: 'fourthTaskName',
  description: "second task description")

TeamsRelationship.create({
  user_id: User.second.id,
  team_id: Team.first.id})
