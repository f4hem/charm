class Charm::Token < ActiveRecord::Base
  include Charm::Helpers
  attr_accessible :client_id, :expire_at, :scope, :token, :user_id, :valid_thru

  self.table_name = 'charm_tokens'

  belongs_to :client

  def expired?
  	expire_at and Time.now >= expire_at
  end

  def expire!
  	expire_at = Time.now
  end

  def refresh!
    self.token = Charm::Helpers.generate_string 64
    self.expire_at = Time.now + 3.days
  end

  def self.clean_invalid
  	where('valid_thru < ?', Time.now).destroy
  end

  def as_json(t)
    super only: %w{token updated_at valid_thru scope }

  end


end
