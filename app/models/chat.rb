class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages

  validates :chat_name, :presence => true,
                        :length => {maximum: 100}

  validates_uniqueness_of :chat_name, :scope => :application_id

  validates_uniqueness_of :number, :scope => :application_id
  validates_numericality_of :number

  scope :find_chat, -> (number){ find_by_number(number) }
end
