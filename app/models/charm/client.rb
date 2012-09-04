class Charm::Client < ActiveRecord::Base
  attr_accessible :client_secret, :description, :status, :title, :user_id

  validates :title, presence: true, length: 2..140

  self.table_name = 'charm_clients'

  has_many :tokens


  def generate_secret
  	self.client_secret = SecureRandom.hex 32
  end

end
