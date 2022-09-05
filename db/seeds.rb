# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  [
    {
      name: 'firstUser',
      handle: "the first",
      email: "user@example.com",
      password: 'foobar',
      password_confirmation: "foobar",
      activated: true,
      activated_at: Time.zone.now
  },
    {
      name: 'secondUser',
      handle: "the second",
      email: "example@example.com",
      password: 'foobar',
      password_confirmation: "foobar",
      activated: true,
      activated_at: Time.zone.now
    },
    {
      name: 'thirdUser',
      handle: "the third",
      email: "thr33@example.com",
      password: 'foobar',
      password_confirmation: "foobar",
      activated: true,
      activated_at: Time.zone.now
    }
  ]
)

Team.create(
  [
    {
      user_id: User.first.id,
      name: 'firstTeam',
      description: "firstTeam description"
    },
    {
      user_id: User.second.id,
      name: 'secondTeam',
      description: "secondTeam description"
    },
    {
      user_id: User.first.id,
      name: 'ThirdTeam',
      description: "thirdTeam description"
    },
    {
      user_id: User.second.id,
      name: 'fourthTeam',
      description: "fourthTeam description"
    },
  ]
)

Project.create(
  [
    {
      team_id: Team.first.id,
      name: 'firstProjectName',
      description: "project description",
      # requirements: "list of requirements, should be a json string"
    },
    {
      team_id: Team.first.id,
      name: 'secondProjectName',
      description: "project description",
      # requirements: "list of requirements, should be a json string"
    },
    {
      team_id: Team.second.id,
      name: 'thirdProjectName',
      description: "project description",
      # requirements: "list of requirements, should be a json string"
    },
    {
      team_id: Team.third.id,
      name: 'fourthProjectName',
      description: "project description",
      # requirements: "list of requirements, should be a json string"
    }
  ]
)

Task.create(
  [ 
    {
      project_id: Project.first.id,
      name: 'taskName',
      description: "task description",
      duedate: 1.day.ago
    },
    {
      project_id: Project.first.id,
      name: 'secondTaskName',
      description: "second task description",
      duedate: 1.month
    },
    {
      project_id: Project.second.id,
      name: 'thirdTaskName',
      description: "Third task description",
      duedate: 1.day
    },
    {
    project_id: Project.second.id,
      name: 'completedTaskName',
      description: "Completed task description",
      duedate: 1.day,
      completed: true,
      completed_at: 1.day.ago
    },
    {
        project_id: Project.third.id,
        name: 'fourthTaskName',
        description: "second task description",
        duedate: 2.day
    }
  ]
)

TeamsRelationship.create(
  [
    {
      user_id: User.second.id,
      team_id: Team.third.id
    },
    {
      user_id: User.first.id,
      team_id: Team.second.id
    },
  ]
)

TeamRequest.create(
  [
    {
      user_id: User.first.id,
      team_id: Team.second.id,
      from_team: true
    },
    {
      user_id: User.second.id,
      team_id: Team.first.id,
      from_team: true
    }
  ]
)