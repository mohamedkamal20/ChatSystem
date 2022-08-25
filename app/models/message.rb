class Message < ApplicationRecord
  belongs_to :chat

  validates :message, :presence => true,
                      :length => {maximum: 500}

  validates_uniqueness_of :number, :scope => :chat_id
  validates_numericality_of :number

  scope :find_message, -> (number){ find_by_number(number) }

  searchkick text_middle: [:message]

  def search_data
    {
      number: number,
      message: message,
      chat_number:chat.number,
      token: chat.application.token
    }
  end
end
