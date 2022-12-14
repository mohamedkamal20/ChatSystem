package repositories


import (
	"chatSystemGoAPIs/models"
)


type ChatRepo interface {
	Insert(chat models.Chat) bool
    ValidApplication(token string) int
    GetApplicationChatsCount(appId int) int
}

type MessageRepo interface {
	Insert(message models.Message) bool
	ValidChat(token string, chatNumber int) int
	GetChatMessagesCount(chatId int) int
}