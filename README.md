# Todo API

<br>

## Headers
<br>

Content-Type always required.
```
--header 'Content-Type: application/json'
```
Authorization required for most endpoints.
```
--header 'Authorization: token'
```

---
<br>

## Endponts
<br>

### Token
- New token: GET /key/new
### Users
- Create: POST /users
  - takes params
  ```
  {
    "user": {
      "handle": "required, limit 50 characters",
      "name": "required, limit 50 characters",
      "email": "required, limit 255 characters",
      "password": "required, limit 140 characters",
      "password_confirmation": "required, limit 140 characters"
    }
  }
  ```
- Index: GET /users
  - Requires valid token in header.
- Show: GET /users/user_id
  - user_id = the users id.
  - Requires valid token in header.
- Edit: PATCH /users/ID
  - ID = the users id.
  - Requires the token belonging to the user in header.
  - takes some or all of these params.

  ```
  {
    "user": {
      "handle": "User",
      "name": "userName",
      "email": "user@example.com",
      "password": "foobar",
      "password_confirmation": "foobar"
    }
  }
  ```
- Delete: DELETE /users/user_id
  - user_id = the users id.
  - Requires the token belonging to the user in header.
  
  <br>

### Teams

- Create: POST /teams
  - Requires valid token in header.
  - takes params
  ```
  {
    "team": {
      "name": "required, limit 50 characters",
      "description": "limit 140 characters"
    }
  }
  ```
- Index: GET /teams
  - Requires valid token in header.
- Show: GET /teams/team_id
  - team_id = the teams id.
  - Requires valid token in header.
- Edit: PATCH /teams/ID
  - ID = the teams id.
  - Requires the token belonging to the team owner in header.
  - takes some or all of these params.

  ```
  {
    "team": {
      "name": "A fantastic team name",
      "description": "a short-ish description of the team"
    }
  }
  ```
- Delete: DELETE /teams/team_id
  - team_id = the teams id.
  - Requires the token belonging to the team owner in header.
    
  <br>

### Projects

- Create: POST /team/team_id/projects
  - team_id = the teams id.
  - Requires valid token in header.
  - Requires team to exist.
  - takes params
  ```
  {
    "project": {
      "name": "required, limit 50 characters",
      "description": "limit 140 characters",
      "requirements": "limit 500 characters, can be stringified json"
    }
  }
  ```
- Index: GET /teams/team_id/projects
  -  team_id = the teams id.
  - Requires valid token in header.
- Show: GET /teams/team_id/projects/project_id
  - team_id = the teams id.
  - project_id = the project id.
  - Requires valid token in header.
- Edit: PATCH /teams/team_id/projects/project_id
  - team_id = the teams id.
  - project_id = the project id.
  - Requires the token belonging to the team owner in header.
  - takes some or all of these params.

  ```
  {
    "project": {
      "name": "A cool name for the project",
      "description": "a short-ish description of the project goals",
      "requirements": "[\"does stuff\", \"must not do certain stuff\", \"does more stuff\" ]"
    }
  }
  ```
- Delete: DELETE /teams/team_id/projects/project_id
  - team_id = the teams id.
  - project_id = the project id.
  - Requires the token belonging to the team owner in header.

<br>

### Tasks
- Create: POST /team/projects/project_id/tasks
  - team_id = the teams id.
  - project_id = the projects id.
  - Requires valid token in header.
  - Requires team and project to exist.
  - takes params
  ```
  {
    "task": {
      "name": "required, limit 50 characters",
      "description": "limit 240 characters",
      "completed": "boolean, false by default",
      "duedate": "datetime, null by default",
      "completed_at": "datetime, null by default"
    }
  }
  ```
- Index: GET /teams/team_id/projects/project_id/tasks
  - team_id = the teams id.
  - project_id = the projects id.
  - Requires valid token in header.
- Show: GET /teams/team_id/projects/project_id/tasks/task_id
  - team_id = the teams id.
  - project_id = the project id.
  - task_id = the tasks id.
  - Requires valid token in header.
- Edit: PATCH /teams/team_id/projects/project_id/tasks/task_id
  - team_id = the teams id.
  - project_id = the project id.
  - task_id = the tasks id.
  - Requires the token belonging to the team owner in header.
  - takes some or all of these params.

  ```
  {
    "task": {
      "name": "A name that accurately sums up the task",
      "description": "A descriptive description describing the task at hand",
      "completed": true,
      "duedate": ""2022-05-05T22:19:32.473Z",
      "completed_at": "2022-03-05T22:19:32.473Z"
    }
  }
  ```
- Delete: DELETE /teams/team_id/projects/project_id/tasks/task_id
  - team_id = the teams id.
  - project_id = the project id.
  - task_id = the tasks id.
  - Requires the token belonging to the team owner in header.
