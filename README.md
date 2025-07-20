# Todo API

## Getting started

<br>

### Basics

<br>

```bash
$ bundle install
```

```bash
$ rails db:migrate
```
*Optional*
```bash
$ rails db:seed
```


### Environment variables

<br>

optionally you can use

*config/local_env.yml*
```
HMAC_SECRET:        theSecretYouChoose
SENDGRID_API_KEY:   theKeyToTheAPI
SENDGRID_EMAIL:     YourSendgridSenderEmail
URL:                http://localhost:3000 // the full url
HOST:               localhost:3000 // could be your app on heroku
DOMAIN:             localhost:3000 // could be heroku.com
APP_NAME:           theName
ORIGIN:             corsOrigin
```

### You should now be able to run it with
```
$ rails server
```

<br>
<hr>
<br>


## Headers
<br>

Content-Type always required.
```
--header 'Content-Type: application/json'
```
Accept is not strictly necessary, but would be good to include
```
--header 'Accept: application/json'
```
Authorization required for most endpoints.
``` 
--header 'Authorization: token'
```

<br>
<hr>
<br>

## Mailers

<br>

### Account activation
  - contains link to "#{ENV["ORIGIN]}/activate" with ACTIVATION_TOKEN, and USER_EMAIL in URL params
    - ACTIVATION_TOKEN = The users activation token to create their activation digest
    - USER_EMAIL = The users email address

<br>

### Password reset / Forgot password
  - contains link to "#{ENV["ORIGIN]}/reset" with RESET_TOKEN, and USER_EMAIL in URL params
    - RESET_TOKEN = The users reset token to create their reset digest
    - USER_EMAIL = The users email address

<br>
<hr>
<br>

## Endponts

<br>

### Account activation
 - Activation: GET /account_activations/ACTIVATION_TOKEN/edit?email=USER_EMAIL
   - ACTIVATION_TOKEN = The activation token used to make their activation_digest
   - USER_EMAIL = The users email address

<br> 

### Password reset / Forgot password

- New password reset token: POST /password_resets/?email=USER_EMAIL
  - USER_EMAIL = The users email address
  - Returns
      ```
      // coming soon... ish
      ```
<br>

- Set new password: PATCH /password_resets/RESET_TOKEN/?email=USER_EMAIL
  - RESET_TOKEN = the users reset token used to make their reset digest
  - USER_EMAIL = The users email address
  - Takes params
    ```
    {
        "user": {
          "password": "required, limit 140 characters",
          "password_confirmation": "required, limit 140 characters"
        }
      }
    ```
  - Returns
  ```
  // coming soon... ish
  ```

<br>

### Token

<br>

- New token: POST /login
  - Takes params
    ```
    {
      "user": {
        "email": "required, limit 255 characters",
        "password": "required, limit 140 characters"
      }
    }
    ```
  - Returns
    ```
    // coming soon... ish
    ```
<br>

### Users

<br>

- Create: POST /users
  - Takes params
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
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Index: GET /users
  - Requires valid token in header.

<br>

- Show: GET /users/USER_ID
  - USER_ID = the users id.
  - Requires valid token in header.

<br>

- Edit: PATCH /users/ID
  - ID = the users id.
  - Requires the token belonging to the user in header.
  - password, password_confirmation, and current_password fields are required to update password
  - Takes some or all of these params.
    ```
    {
      "user": {
        "handle": "User",
        "name": "userName",
        "email": "user@example.com",
        "password": "foobar",
        "password_confirmation": "foobar",
        "current_password": "barfoo"
      }
    }
    ```

  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Delete: DELETE /users/USER_ID
  - USER_ID = the users id.
  - Requires the token belonging to the user in header.
  - Returns
    ```
    // status no content
    ```
  <br>

### Teams

<br>

- Create: POST /teams
  - Requires valid token in header.
  - Takes params
    ```
    {
      "team": {
        "name": "required, limit 50 characters",
        "description": "limit 140 characters"
      }
    }
    ```
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Index: GET /teams
  - Requires valid token in header.
  - Returns
    ```
    // coming soon... ish
    ```
<br>

- Discover: GET /teams/discover
  - Requires valid token in header.
  - Returns
    ```
    // coming soon... ish
    ```
<br>

- Show: GET /teams/TEAM_ID
  - TEAM_ID = the teams id.
  - Requires valid token in header.
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Edit: PATCH /teams/ID
  - ID = the teams id.
  - Requires the token belonging to the team owner in header.
  - Takes some or all of these params.
    ```
    {
      "team": {
        "name": "A fantastic team name",
        "description": "a short-ish description of the team"
      }
    }
    ```
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Delete: DELETE /teams/TEAM_ID
  - TEAM_ID = the teams id.
  - Requires the token belonging to the team owner in header.
  - Returns
    ```
    // status no content
    ```
  <br>

### Projects

<br>

- Create: POST /team/TEAM_ID/projects
  - TEAM_ID = the teams id.
  - Requires valid token in header.
  - Requires team to exist.
  - Takes params
    ```
    {
      "project": {
        "name": "required, limit 50 characters",
        "description": "limit 140 characters",
        "requirements": "limit 500 characters, can be stringified json"
      }
    }
    ```
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Index: GET /teams/TEAM_ID/projects
  -  TEAM_ID = the teams id.
  - Requires valid token in header.
  - Returns
    ```
    // coming soon... ish
    ```
<br>

- Show: GET /teams/TEAM_ID/projects/PROJECT_ID
  - TEAM_ID = the teams id.
  - PROJECT_ID = the project id.
  - Requires valid token in header.
  - Returns
    ```
    // coming soon... ish
    ```
<br>
  
- Edit: PATCH /teams/TEAM_ID/projects/PROJECT_ID
  - TEAM_ID = the teams id.
  - PROJECT_ID = the project id.
  - Requires the token belonging to the team owner in header.
  - Takes some or all of these params.
    ```
    {
      "project": {
        "name": "A cool name for the project",
        "description": "a short-ish description of the project goals",
        "requirements": "[\"does stuff\", \"must not do certain stuff\", \"does more stuff\" ]"
      }
    }
    ```
  - Returns
    ```
    // coming soon... ish
    ```
<br>

- Delete: DELETE /teams/TEAM_ID/projects/PROJECT_ID
  - TEAM_ID = the teams id.
  - PROJECT_ID = the project id.
  - Requires the token belonging to the team owner in header.
  - Returns
    ```
    // status no content
    ```

<br>

### Tasks

<br>

- Create: POST /team/projects/PROJECT_ID/tasks
  - TEAM_ID = the teams id.
  - PROJECT_ID = the projects id.
  - Requires valid token in header.
  - Requires team and project to exist.
  - Takes params
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
  - Returns
    ```
    // coming soon... ish
    ```

<br>
  
- Index: GET /teams/TEAM_ID/projects/PROJECT_ID/tasks
  - TEAM_ID = the teams id.
  - PROJECT_ID = the projects id.
  - Requires valid token in header.
  - Returns
    ```
    // coming soon... ish
    ```

<br>
  
- Show: GET /teams/TEAM_ID/projects/PROJECT_ID/tasks/TASK_ID
  - TEAM_ID = the teams id.
  - PROJECT_ID = the project id.
  - TASK_ID = the tasks id.
  - Requires valid token in header.
  - Returns
    ```
    // coming soon... ish
    ```

<br>
  
- Edit: PATCH /teams/TEAM_ID/projects/PROJECT_ID/tasks/TASK_ID
  - TEAM_ID = the teams id.
  - PROJECT_ID = the project id.
  - TASK_ID = the tasks id.
  - Requires the token belonging to the team owner in header.
  - Takes some or all of these params.
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
  - Returns
    ```
    // coming soon... ish
    ```

<br>
  
- Delete: DELETE /teams/TEAM_ID/projects/PROJECT_ID/tasks/TASK_ID
  - TEAM_ID = the teams id.
  - PROJECT_ID = the project id.
  - TASK_ID = the tasks id.
  - Requires the token belonging to the team owner in header.
  - Returns
    ```
    // status no content
    ```


### Memberships / members


<br>

#### User routes

- Index: GET /users/USER_ID/memberships.
  - USER_ID = the users id.
  - Requires valid token belonging to the user in header.
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Show: GET /users/USER_ID/requests/MEMBERSHIP_ID
  - USER_ID = the users id.
  - MEMBERSHIP_ID = the membership id.
  - Requires valid token belonging to the user in header.
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Delete: DELETE /users/USER_ID/members/MEMBERSHIP_ID
  - USER_ID = the users id.
  - MEMBERSHIP_ID = the memberships id.
  - Requires valid token belonging to the user in header.
  - Returns
    ```
    // status no content
    ```

<br>

#### Team routes

- Index: GET /teams/TEAM_ID/members.
  - TEAM_ID = the teams id.
  - Requires valid token in header.
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Show: GET /teams/TEAM_ID/members/MEMBERSHIP_ID
  - TEAM_ID = the teams id.
  - MEMBERSHIP_ID = the memberships id.
  - Requires valid token in header.
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Delete: DELETE /teams/TEAM_ID/members/MEMBERSHIP_ID
  - TEAM_ID = the teams id.
  - MEMBERSHIP_ID = the membership id.
  - Requires the token belonging to the team owner in header.
  - Returns
    ```
    // status no content
    ```

<br>

### Membership requests

<br>

#### User routes

- Create: POST /users/USER_ID/requests

  - This is used by a team owner to send a request to a user

  - USER_ID = the users id
  - Takes params
    ```
    {
      "team": {
        "TEAM_ID": "required, integer team id, team must exist, and you must be the owner"
      }
    }
    ```
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Index: GET /users/USER_ID/requests.
  - USER_ID = the users id.
  - Requires valid token in header.
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Show: GET /users/USER_ID/requests/REQUEST_ID
  - USER_ID = the users id.
  - REQUEST_ID = the requests id.
  - Requires valid token in header.
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Delete: DELETE /users/USER_ID/requests/REQUEST_ID
  - USER_ID = the users id.
  - REQUEST_ID = the requests id.
  - Requires the token belonging to the user in header.
  - user must be the sender of the request.
  - Returns
    ```
    // status no content
    ```
  
<br>

- Accept: PATCH /users/USER_ID/requests/REQUEST_ID/accept
  - USER_ID = the users id.
  - REQUEST_ID = the requests id.
  - Requires the token belonging to the user in header.
  - user must be the recipient of the request.
  - Returns
    ```
    // coming soon... ish
    ```
  
<br>

- Reject: PATCH /users/USER_ID/requests/REQUEST_ID/reject
  - USER_ID = the users id.
  - REQUEST_ID = the requests id.
  - Requires the token belonging to the user in header.
  - user must be the recipient of the request.
  - Returns
    ```
    // coming soon... ish
    ```
  
<br>

#### Team routes

- Create: POST /teams/TEAM_ID/requests
  - This is used by a user to send a request to a team
  - TEAM_ID = the teams id.
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Index: GET /teams/TEAM_ID/requests.
  - TEAM_ID = the teams id.
  - Requires valid token in header.
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Show: GET /teams/TEAM_ID/requests/REQUEST_ID
  - TEAM_ID = the teams id.
  - REQUEST_ID = the requests id.
  - Requires valid token in header.
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Delete: DELETE /teams/TEAM_ID/requests/REQUEST_ID
  - TEAM_ID = the teams id.
  - REQUEST_ID = the requests id.
  - Requires the token belonging to the team owner in header.
  - team must be the sender of the request.
  - Returns
    ```
    // status no content
    ```

<br>

- Accept: PATCH /teams/TEAM_ID/requests/REQUEST_ID/accept
  - TEAM_ID = the teams id.
  - REQUEST_ID = the requests id.
  - Requires the token belonging to the team owner in header.
  - team must be the recipient of the request.
  - Returns
    ```
    // coming soon... ish
    ```

<br>

- Reject: PATCH /teams/TEAM_ID/requests/REQUEST_ID/reject
  - TEAM_ID = the teams id.
  - REQUEST_ID = the requests id.
  - Requires the token belonging to the team owner in header.
  - team must be the recipient of the request.
  - Returns
    ```
    // coming soon... ish
    ```

<br>