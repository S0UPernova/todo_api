class ApplicationController < ActionController::API
  include ApplicationHelper
   before_action :require_jwt

  # Runs token validations, and returns error messages
  def require_jwt
    response.headers['Content-Type'] = 'application/json'
    token = request.headers["Authorization"]
    if !token
      head :forbidden
      message = {"Token error": "Error Token missing,
                  Please send a valid token with your request"}
      response.body = message.to_json
      # response.headers['Content-Type'] = 'application/json; charset=utf-8'
    elsif !valid_token(token)
      head :forbidden
      message = {"Token error": "Error decoding the JWT: "}
      response.body = message.to_json
      # response.headers['Content-Type'] = 'application/json; charset=utf-8'
    elsif token_expired(token)
      head :forbidden
      message = {"Token error": "Error token expired,
                  Please send a valid token with your request"}
      response.body = message.to_json
      # response.headers['Content-Type'] = 'application/json; charset=utf-8'
    end
  end

  private
    
  def valid_token(token)
    unless token
      return false
    end
    begin
      decoded_token = decode_token(token)
      raise "error" if !decoded_token[0].include?("exp")
    rescue RuntimeError
      Rails.logger.warn "Error token must contain experation: "
      return false
    rescue JWT::DecodeError
      Rails.logger.warn "Error decoding token: "
      return false
    end
    return true
  end

  # this is separate because response.body does not work from here,
  # so I needed bools for the if statements above
  def token_expired(token)
    begin
      decoded_token = decode_token(token)
    rescue JWT::ExpiredSignature
      Rails.logger.warn "Error token expired: "
      return true
    rescue JWT::DecodeError
    end
    return false
  end

  def decode_token(token)
    leeway = 30 # seconds

    decoded_token = JWT.decode token,
      ENV['HMAC_SECRET'],
      true,
      { exp_leeway: leeway, algorithm: 'HS256' }
    return decoded_token
  end

  # def current_user
  #   begin
  #     token = request.headers["Authorization"]
  #     token_id = decode_token(token)[0]["data"]["user_id"]
  #     user = User.find(token_id)
  #     if user
  #       return user
  #     else
  #       head :forbidden
  #       return false
  #     end
  #   rescue JWT::DecodeError
  #     Rails.logger.warn "Error decoding the JWT: "
  #   end
  #   head :forbidden
  #   false
  # end
end