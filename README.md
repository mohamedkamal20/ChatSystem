# Chat System

### Overview
This a simple Chat System task that create chat under application and add messages for this chat.
### Goals
* Create CRUD operations for application, chat and messages API.
* Search through messages (partially match) of specific chat on elasticSearch db.
* Handle multiple requests concurrently.
* Containerize the task.
### Requirements
In order to run the application please follow the steps:
- Ubuntu running OS.
### Quick start
* Clone the project.

### Test services
* Postman or curl command line\
  `/api/v1/applications/ [GET]`\
  `/api/v1/applications/{id} [GET]`\
  `/api/v1/applications/ [POST] {"application_name": "app_name"}`\
  `/api/v1/applications/{id} [PATCH] {"application_name": "app_name"}`\
  `/api/v1/applications/{token}/chats [GET]`\
  `/api/v1/applications/{token}/chats/{id} [GET]`\
  `/api/v1/applications/{token}/chats/{id} [PATCH] {"chat_name": "chat_name"}`\
  `/api/v1/applications/{token}/chats/{chat_id}/messages [GET]`
### Test against Database
* Iam using MySQL as my main database. 
  



