module Charm::Helpers
  def get_scopes
    scope.split(',')
  end

  def get_scopes_details
    get_scopes.map{|key|
      if Charm.scopes.has_key? key
        Charm.scopes[key].tap{|hash|
          hash[:key] = key
        }
      end
    }.compact
  end

  def has_scope?(scope)
    get_scopes.include? scope.to_s
  end


  def self.generate_string(length = 32)
    SecureRandom.hex length
  end

end