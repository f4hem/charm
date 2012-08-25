class Charm::Token < ActiveRecord::Base
  attr_accessible :client_id, :expire_at, :scope, :token, :user_id, :valid_thru

  self.table_name = 'charm_tokens'

  belongs_to :client

  


  def expired?
  	expire_at and Time.now >= expire_at
  end

  def expire!
  	expire_at = Time.now
  end

  def self.clean_invalid
  	where('valid_thru < ?', Time.now).destroy
  end

end
