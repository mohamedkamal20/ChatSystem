# Chat System

### Overview
This is a simple Chat System task that create chat under application and add messages for this chat.
### Goals
* Create CRUD operations for application, chat and messages Endpoints.
* Search through messages (partially match) of specific chat on elasticSearch db.
* Run background jobs to update chat count and message count.
* Consume from RabbitMQ messages sent from Golang endpoints.
* Create Golang endpoints for Chat and Message to concurrency, see readme file by navigating to chatSystemGoAPIs folder.
* Containerize the task.
### Requirements
In order to run the application please follow the steps:
- Ubuntu running OS.
- Make sure there ports are not used by another process:
  * port `3000` for rails application.
  * port `8085` for goLang application.
  * port `3307` for default mysql port.
  * port `9200` for default elasticSearch port.
  * port `6379` for default redis port.
  * port `5672` for default rabbitMQ port.
### Quick start
* Clone the project.
* Import `ChatSystem.postman_collection.json` to your postman.
* Run `sudo docker-compose rm -f` to make sure no images cached.
* Run `sudo docker-compose pull` .
* Run `sudo docker-compose up --build -d`.
* Run `sudo docker exec -it mySql sh` to create Database.
  * Inside shel run `mysql -u root -h mySql --password=root`.
  * `CREATE DATABASE IF NOT EXISTS ChatSystem_development;` 
  * `exit`.
* Exit mySql shel by run `exit`
* Run `sudo docker exec -it ChatSystemApp sh` to run Database migrations.
  * Inside shel run`rails db:migrate`. 
  * `exit`. 


### Gem Description
* [active_model_serializers](https://github.com/rails-api/active_model_serializers) for customize json response. 
* [searchkick](https://github.com/ankane/searchkick) for search on elasticSearch db and reindexing the model.
* [bunny](https://github.com/ruby-amqp/bunny) for rabbitMQ consumer.
* [sidekiq](https://github.com/mperham/sidekiq) for background jobs using redis.
* [sidekiq-cron](https://github.com/ondrejbartas/sidekiq-cron) for schedule sidekiq jobs to run every period of time.


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
  *`/api/v1/applications/{token}/chats/{chat_id}/messages/{id} [PATCH] {"message"{"message":"message-text"}}`
### Test against Database
* Iam using MySQL as my main database and elasticSearch for searching messages. 
  



