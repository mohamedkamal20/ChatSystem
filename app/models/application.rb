class Application < ApplicationRecord
  has_many :chats


  validates :application_name, :presence => true,
                                :length => {maximum: 100},
                                :uniqueness => true

  validates :token, :uniqueness => true,
                    :length => {:maximum => 250}

end
