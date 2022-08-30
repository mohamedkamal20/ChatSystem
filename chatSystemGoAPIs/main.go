package main

import (
	api "chatSystemGoAPIs/controllers"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"os"
)

func setEnvVariables()  {
	os.Setenv("rabbitMQHost", "amqp://guest:guest@rabbitMQ:5672/")
	os.Setenv("rabbitMQChatsQueue", "chats_development")
	os.Setenv("rabbitMQMessagesQueue", "messages_development")
	os.Setenv("mySqlDataStoreName", "root:root@tcp(mySql:3306)/ChatSystem_development")
	os.Setenv("redisHost", "redis:6379")
	os.Setenv("redisDB", "1")
}

func main() {
	// set env variables
	setEnvVariables()

	r := mux.NewRouter()
	r.HandleFunc("/api/v1/applications/{token}/chats",api.CreateChat).Methods("POST")
	r.HandleFunc("/api/v1/applications/{token}/chats/{chat_number}/messages", api.CreateMessage).Methods("POST")

	log.Fatal(http.ListenAndServe(":8085", r))
}