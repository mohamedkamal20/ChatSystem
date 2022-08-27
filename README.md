# Chat System

### Overview
This is a simple Chat System task that create chat under application and add messages for this chat.
### Goals
* Create CRUD operations for application, chat and messages Endpoints.
* Search through messages (partially match) of specific chat on elasticSearch db.
* Run background jobs to update chat count and message count.
* Consume from RabbitMQ messages sent from Golang endpoints.
* Containerize the task.
### Requirements
In order to run the application please follow the steps:
- Ubuntu running OS.
### Quick start
* Clone the project.
* run docker-compose up the docker file.


### Gem Description
* [active_model_serializers](https://github.com/rails-api/active_model_serializers) for customize json response. 
* [searchkick](https://github.com/ankane/searchkick) for search on elasticSearch db and reindexing the model.

### Test services
* ##### Postman or curl command line
  *`/api/v1/applications/ [GET]`\
  *`/api/v1/applications/{id} [GET]`\
  *`/api/v1/applications/ [POST] {"application_name": "app_name"}`\
  *`/api/v1/applications/{id} [PATCH] {"application_name": "app_name"}`\
  *`/api/v1/applications/{token}/chats [GET]`\
  *`/api/v1/applications/{token}/chats/{id} [GET]`\
  *`/api/v1/applications/{token}/chats/{id} [PATCH] {"chat_name": "chat_name"}`\
  *`/api/v1/applications/{token}/chats/{chat_id}/messages [GET]`
  *`/api/v1/applications/{token}/chats/{chat_id}/messages/search [GET] {"message":"message"}`
### Test against Database
* Iam using MySQL as my main database and elasticSearch for searching messages. 
  



