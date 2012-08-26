class Charm::Token < ActiveRecord::Base
  attr_accessible :client_id, :expire_at, :scope, :token, :user_id, :valid_thru

  self.table_name = 'charm_tokens'

  belongs_to :client

  def generate_token
    token = SecureRandom.base64 256
  end

  
  def get_scopes
    scope.split(',')
  end

  def get_scopes_details
    get_scopes.map{|key|
      Charm.scopes[key].tap{|hash|
        hash[:key] = key
      }
    }
  end

  def has_scope?(scope)
    get_scopes.include? scope.to_s
  end


  def expired?
  	expire_at and Time.now >= expire_at
  end

  def expire!
  	expire_at = Time.now
  end

  def refresh!
    generate_token
    expire_at = Time.now + 3.days
  end

  def self.clean_invalid
  	where('valid_thru < ?', Time.now).destroy
  end

end
