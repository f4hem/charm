class CharmController < ApplicationController

  before_filter :prepare_environment, only: [:authorize, :authorize_accept]

  skip_before_filter :protect_from_forgery, only: [:obtain_token]

  def authorize



  end

  def authorize_accept


    @token = @client.tokens.new

    @token.generate_token
    @token.user_id = 123 # = current_user

    if @client.response_type == 'code'
      @token.expire!
      callback = "#{redirect_uri}?token=#{@token.token}"
    elsif @client.response_type == 'token'
      callback = "#{redirect_uri}#token=#{@token.token}"
    end

    if @token.save

      redirect_to callback

    else


    end
  end

  def obtain_token
    if params[:token].is_a?(String)
      [params[:token]]
    else
      params[:token]
    end
    @client = Charm::Client.find_by_id_and_client_secret(params[:client_id], params[:client_secret])
    @tokens = @client.tokens.where(token: [tokens]) 

    if @tokens
      token_list = []
      @tokens.each do |token|
        token.refresh!
        token.save
        token_list.push token.token
        expire_at ||= token.expire_at
      end

      render(json: {
        token: refreshed_tokens,
        expire_at: expire_at
      }, callback: params[:callback])

    end   


  end

  def inspect_token


  end

  private


  def prepare_environment
    @client = Charm::Client.find_by_id params[:client_id]
    @token = Charm::Token.find_by_token params[:token]

  end

end
