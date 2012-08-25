class Charm::Client < ActiveRecord::Base
  attr_accessible :client_id, :client_secret, :description, :status, :title, :user_id

  self.table_name = 'charm_clients'

  has_many :tokens

end
