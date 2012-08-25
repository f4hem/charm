class CharmController < ApplicationController

  before_filter :prepare_environment, only: [:authorize, :authorize_accept]

  skip_before_filter :protect_from_forgery, only: [:obtain_token]

  def authorize



  end

  def authorize_accept


    @token = @client.tokens.new

    @token.token = generate
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
    @expired_token = Charm::Token.find_by_token params[:token]
    if @expired_token
      @client = Charm::Client.find_by_id_and_client_secret(params[:client_id], params[:client_secret])
      if @expired_token.client == @client

        @expired_token.refresh!
        @expired_token.save

        render json: {
          token: @expired_token.token,
          expire_at: @expired_token.expire_at
        }
      end
    end   

  end

  private

  def generate
    SecureRandom.base64 256
  end

  def prepare_environment
    @client = Charm::Client.find_by_id params[:client_id]

  end

end
