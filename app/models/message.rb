class Message < ApplicationRecord
  belongs_to :chat

  validates :message, :presence => true,
                      :length => {maximum: 500}

  validates_uniqueness_of :number, :scope => :chat_id
  validates_numericality_of :number
end
