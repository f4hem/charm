class CharmController < ApplicationController

  before_filter :prepare_environment, only: [:authorize, :authorize_accept]

  skip_before_filter :protect_from_forgery, only: [:obtain_token]
  
  respond_to :json  

  def authorize
    @token = @client.tokens.find_by_user_id current_user
    if @token
      callback = callback_url
      if @token.save
        redirect_to callback
      end
    end
  end

  def authorize_accept
    @token = @client.tokens.new
    @token.user_id = current_user
    @token.scope = @client.scope
    callback = callback_url

    if @token.save
      redirect_to callback
    end
  end

  def obtain_token
    tokens = if params[:token].is_a?(String)
      [params[:token]]
    elsif params[:token].is_a?(Array)
      params[:token]
    end
    @client = Charm::Client.find_by_id_and_client_secret(params[:client_id], params[:client_secret])
    if @client
      @tokens = @client.tokens.where(token: tokens) 

      if @tokens.size > 0
        @tokens.each do |token|
          token.refresh!
          token.save
        end

        render(json: @tokens, callback: params[:callback])
      else
        raise "no_such_token"
      end   

    else
      raise 'wrong_credentials'
    end
  end

  def inspect_token
    @token = Charm::Token.find_by_token params[:token]
    respond_with @token
  end

  private

  def callback_url
    parameters = {}
    @token.token = Charm::Helpers.generate_string 64
    parameters[:token] = @token.token

    symbol = if @client.response_type == 'hash'
      @token.expire_at = Time.now + 3.days
      parameters[:expire_at] = @token.expire_at.to_i
      '#'
    else
      # expired token is similar to 'code'. Client has to obtain a new one with his credentials
      @token.expire_at = Time.now
      '?'
    end
    parameters[:state] = params[:state]

    "#{@client.redirect_uri}#{symbol}#{parameters.to_query}"
  end

  def prepare_environment
    @client = Charm::Client.find_by_id params[:client_id] if params[:client_id]
    @token = Charm::Token.find_by_token params[:token]
  end

end
